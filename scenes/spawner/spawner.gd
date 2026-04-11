class_name Spawner
extends Node2D

@export var enemy: PackedScene
@export var min_distance: float = 200.0
@export var max_distance: float = 300.0

var max_attemps: int = 10

# Called when ready
func _ready() -> void:
	global_position = PositionController.player_position
	PositionController.position_updated.connect(_update_position)

# Updates node position
func _update_position(player_position: Vector2) -> void:
	global_position = player_position

# Spawns a group of enemies
func spawn_enemies(generation_points: int) -> void:
	while generation_points > 0:
		var enemy_points := upgrade_chance(1, generation_points)
		generation_points -= enemy_points
		spawn_enemy(enemy_points)

# Has a chance to upgrade the enemy value
func upgrade_chance(enemy_points: int, level_points: int) -> int:
	if randi_range(0, 100) < level_points:
		return upgrade_chance(enemy_points + 1, level_points)
	return enemy_points

# Spawns a single enemy of the given value in a random position
func spawn_enemy(enemy_points: int) -> bool:
	var enemy_position := new_spawn_position()
	if enemy_position.length() == 0:
		return false
	var new_enemy := enemy.instantiate()
	new_enemy.global_position = enemy_position
	# TODO: enemy points stablish the type of enemy to spawn 
	new_enemy.health = enemy_points * 5
	get_parent().add_child(new_enemy)
	return true

func new_spawn_position() -> Vector2:
	for i in range(0, max_attemps):
		var angle := randf_range(0.0, 2*PI)
		var length := randf_range(min_distance, max_distance)
		var new_pos := Vector2.from_angle(angle).normalized() * length
		if is_valid_spawn_area(new_pos):
			return new_pos + global_position
	return Vector2.ZERO

func is_valid_spawn_area(location: Vector2) -> bool:
	# Create a raycast in the given location
	var raycast := RayCast2D.new()
	raycast.position = location
	for i in range(1, 8):
		raycast.set_collision_mask_value(i, false)
	raycast.set_collision_mask_value(8, true)
	raycast.hit_from_inside = true
	raycast.target_position = Vector2.UP.normalized()
	# Add it to the tree
	add_child(raycast)
	# Detect collisions with spawneable area
	raycast.force_raycast_update()
	var valid := raycast.is_colliding()
	# Destroy raycast
	raycast.queue_free()
	return valid
