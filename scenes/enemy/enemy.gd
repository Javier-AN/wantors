class_name Enemy
extends Node2D

@export var animation: AnimatedSprite2D

var detection_distance: float = 150.0
var speed: float = 50.0

var _velocity: Vector2

# Called every tick
func _physics_process(delta: float) -> void:
	_update_velocity()
	position += _velocity * delta
	_update_animation()

# Updates the velocity
func _update_velocity():
	var distance: Vector2 = PositionController.player_position - position
	if distance.length() < detection_distance and distance.length() > 1:
		_velocity = distance.normalized() * speed
	else:
		_velocity = Vector2.ZERO

# Changes the animation depending on the current state
func _update_animation():
	if _velocity.length() > 0:
		animation.play("run")
		animation.flip_h = _velocity.x < 0
	else:
		animation.play("idle")
