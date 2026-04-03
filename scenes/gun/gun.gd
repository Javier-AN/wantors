class_name Gun
extends Node2D

@export var muzzle: Marker2D
@export var bullet : PackedScene

var bullet_speed: float = 250.0
var shooting_cooldown: float = 0.1

var _direction: Vector2
var _time_since_shoot: float

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

# Generates a projectile and sets its properties
func _generate_bullet():
	var b = bullet.instantiate()
	b.velocity = Vector2.from_angle(muzzle.global_transform.get_rotation())
	b.velocity *= bullet_speed
	b.velocity += owner.velocity
	b.transform = muzzle.global_transform
	owner.owner.add_child(b)
