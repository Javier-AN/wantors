class_name Spawner
extends Node2D
## A node 2D that spawns enemies around the player.
## Enemies can be spawned until a given mob cap. When the mob cap is reached,
## a signal is emitted no more enemies can spawn.
## After the mob cap is reached and all the enemies die, another signal is 
## emitted so the mob count can be reset.

## Emitted when the number of spawns reaches the mob cap.
signal mob_cap_reached
## Emitted when all the spawned enemies have died.
signal enemies_cleared

## Different types of enemies that can be spawned.
@export var enemies: Array[PackedScene]
## Minimum distance from the player at which an enemy can spawn.
@export var min_distance: float = 300.0
## Maximum distance from the player at which an enemy can spawn.
@export var max_distance: float = 600.0
## Maxmium number of attempts to find a valid location to spawn an ememy.
## After failing this many attempts, the spawn is cancelled.
@export var max_attempts: int = 10
## Time in between horde spawns.
@export var cooldown: float = 0.05

## Maximum amount of mobs that can be spawned between resets.
var mob_cap: int = 50

# Private variables
var _mob_count: int = 0
var _mob_cap_reached: bool = false
var _alive_enemies: int = 0

## Keeps track of the player's position.
@onready var marker: Marker2D = $PlayerMarker
## Keeps track of the player's position.
@onready var _enemy_container: Node2D = $EnemyContainer
@onready var _spawn_area_detector_scene: PackedScene = load("res://scenes/components/spawn_area_detector/spawn_area_detector.tscn")


# Called when ready
func _ready() -> void:
	_update_marker_position(PositionController.player_position)
	PositionController.position_updated.connect(_update_marker_position)


# Updates marker position
func _update_marker_position(player_position: Vector2) -> void:
	marker.global_position = player_position


## Resets the mob count to 0.
##
## If [param new_cap] is set, the mob cap is changed to its value.
func reset_mob_count(new_cap: int = 0) -> void:
	_mob_count = 0
	_mob_cap_reached = false
	if new_cap > 0:
		mob_cap = new_cap


## Spawns a group of enemies.
## 
## [param amount] dictates the number of enemies that should try to spawn.
## [param upgrade_chance] should be a number between 0.0 and 1.0, it stablishes
## the chance of an enemy to become of a higher type.
func spawn_enemies(amount: int, upgrade_chance: float = 0.0) -> void:
	for i in range(amount):
		if _mob_count >= mob_cap:
			_mob_cap_reached = true
			mob_cap_reached.emit()
			return
		var enemy_type := _upgrade(0, upgrade_chance)
		if spawn_enemy(enemy_type):
			_mob_count += 1
			_alive_enemies += 1
			await get_tree().create_timer(cooldown).timeout


# Has a chance to upgrade the enemy type
func _upgrade(enemy_type: int, upgrade_chance: float = 0.0) -> int:
	# Check if max upgrade reached
	if enemy_type == enemies.size() - 1:
		return enemy_type
	# Chance for upgrade
	if randf_range(0.0, 1.0) < upgrade_chance:
		return _upgrade(enemy_type + 1, upgrade_chance)
	# No upgrade
	return enemy_type


## Tries to spawn a single enemy completely independent to the mob cap.
## 
## [param enemy_type] dictates the type of the spawned enemy.
## Returns [code]true[/code] if the spawn is successful.
func spawn_enemy(enemy_type: int = 0) -> bool:
	# Tries to find a new valid spawn position
	var enemy_position := _new_spawn_position()
	# If it fails, it returns false
	if enemy_position.length() == 0:
		return false
	# If it success, spawns the enemy in the position and returns true
	var new_enemy: Creature = enemies[enemy_type].instantiate()
	new_enemy.global_position = enemy_position
	new_enemy.disappeared.connect(_enemy_died)
	_enemy_container.add_child(new_enemy)
	return true


# Tries to find a valid random spawn position
func _new_spawn_position() -> Vector2:
	for i in range(0, max_attempts):
		# Random angle
		var player_angle := PositionController.player_direction.angle()
		var angle := randf_range(player_angle + PI/4, player_angle + 7*PI/4)
		# Random valid distance
		var length := randf_range(min_distance, max_distance)
		# Build the position vector from the random values
		var new_pos := marker.global_position
		new_pos += Vector2.from_angle(angle).normalized() * length
		# Check if its in a valid spawn area
		if _is_valid_spawn_area(new_pos):
			return new_pos
	# If all attempts fail, return the ZERO vector
	return Vector2.ZERO


# Checks wether the given location is in a valid spawn area
func _is_valid_spawn_area(location: Vector2) -> bool:
	# Create a detector in the given location
	var detector: RayCast2D = _spawn_area_detector_scene.instantiate()
	detector.position = location
	# Add it to the tree
	add_child(detector)
	# Detect collisions with spawneable area
	detector.force_raycast_update()
	var valid := detector.is_colliding()
	# Destroy raycast
	detector.queue_free()
	return valid


# Called when an enemy dies
func _enemy_died():
	_alive_enemies -= 1
	if _mob_cap_reached and _alive_enemies <= 0:
		enemies_cleared.emit()
