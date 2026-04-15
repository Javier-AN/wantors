class_name Gun
extends Node2D

# Nodes
@export var muzzle: Marker2D
@export var bullet : PackedScene

# Exported variables
@export var shooting_cooldown: float = 0.1
@export var bullet_speed: float = 250.0
@export var bullet_damage: int = 5
@export var bullet_knockback_factor: float = 0.1
@export var bullet_targets: Array[int] = [2]

# Private variables
var _direction: Vector2
var _time_since_shoot: float

# Called when ready
func _ready() -> void:
	_global_update_stats()
	StatsController.gun_stats_must_update.connect(_update_stats)

# Updates stat values
func _update_stats(stats: StatsClass.GunStats) -> void:
	bullet_speed = stats.bullet_speed
	bullet_damage = stats.bullet_damage
	bullet_knockback_factor = stats.bullet_knockback_factor
	shooting_cooldown = stats.shooting_cooldown
	_global_update_stats()

# Tells global controller values were changed
func _global_update_stats():
	var stats := StatsClass.GunStats.new(bullet_speed, bullet_damage, bullet_knockback_factor, shooting_cooldown)
	StatsController.update_gun_stats(stats)

# Called every tick
func _physics_process(delta: float) -> void:
	_get_input()
	_update_angle()
	_shoot(delta)

# Reads input and updates the direction vector
func _get_input():
	_direction.x = Input.get_axis("attack_left", "attack_right")
	_direction.y = Input.get_axis("attack_up", "attack_down")

# Updates the angle
func _update_angle():
	if _direction.length() > 0:
		rotation = _direction.angle()

# Controls shooting
func _shoot(delta):
	_time_since_shoot += delta
	if _direction.length() > 0 and _time_since_shoot >= shooting_cooldown:
		_generate_bullet()
		_time_since_shoot = 0

# Generates a bullet and sets its properties
func _generate_bullet():
	var b: Bullet = bullet.instantiate()
	# Direction of the bullet depends on where the gun is pointing
	b.transform = muzzle.global_transform
	b.velocity = Vector2.from_angle(muzzle.global_transform.get_rotation())
	b.velocity *= bullet_speed
	# The velocity is relative to its origin
	b.velocity += owner.velocity
	# Bullet targets
	for target in bullet_targets:
		b.set_collision_mask_value(target, true)
	# Other stats
	b.damage = bullet_damage
	b.knockback_factor = bullet_knockback_factor
	owner.owner.add_child(b)
