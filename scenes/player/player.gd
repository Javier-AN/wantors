class_name Player
extends CharacterBody2D

@export var animation: AnimatedSprite2D

var _speed: float = 120.0
var _direction: Vector2
var _facing: float

func _physics_process(_delta: float) -> void:
	_get_input()
	_update_velocity()
	_update_animation()
	move_and_slide()
	if velocity.length() > 0:
		PositionController.update_position(position)

# Reads input and updates the direction vector
func _get_input():
	_direction.x = Input.get_axis("move_left", "move_right")
	_direction.y = Input.get_axis("move_up", "move_down")
	# Limit diagonal speed only when necesary
	if _direction.length() > 1:
		_direction = _direction.normalized()
	_facing = Input.get_axis("attack_left", "attack_right")

# Updates the movement velocity
func _update_velocity():
	velocity = _direction * _speed

# Changes the animation depending on the current state
func _update_animation():
	if _facing != 0:
		animation.flip_h = _facing < 0
	if _direction.length() > 0:
		animation.play("run")
		# Character velocity affects animation velocity
		var scale_value = 0.5 + _direction.length() / 2
		# Character walks backwards when facing the opposite direction
		var scale_sign = sign(_direction.x) * (-1 if animation.flip_h else 1)
		animation.speed_scale = scale_sign * scale_value
	else:
		animation.play("idle")
