class_name Player
extends Mob

@export var gun: Node2D

var _facing: float

# Called when ready
func _ready() -> void:
	super()
	health = 100000
	_timers["last_hit"] = 0.0
	PositionController.update_position(global_position)

# Called every tick
func _physics_process(delta: float) -> void:
	if not _dead:
		super(delta)
	if _direction.length() > 0:
		PositionController.update_position(global_position)

# Reads input and updates the direction vectors
func _update_direction():
	_direction.x = Input.get_axis("move_left", "move_right")
	_direction.y = Input.get_axis("move_up", "move_down")
	_direction = _direction.limit_length()
	_facing = Input.get_axis("attack_left", "attack_right")

# Updates the sprite animation
func _update_animation():
	if _facing != 0:
		animation.flip_h = _facing < 0
	if _direction.length() > 0:
		animation.play("run")
		# Character velocity affects animation velocity
		var scale_value = 0.5 + _direction.length() / 2
		# Character walks backwards when facing the opposite direction
		var scale_sign = -1 if _direction.x < 0 != animation.flip_h else 1
		animation.speed_scale = scale_sign * scale_value
	else:
		animation.play("idle")

# Lowers health
func take_hit(damage: int, _velocity := Vector2.ZERO):
	if _timers["last_hit"] > damage_effect_time:
		_timers["last_hit"] = 0.0
		super(damage, _velocity)

# Called when health reaches zero
func _die():
	super()
	animation.play("idle")
	modulate = Constants.DAMAGE_COLOR
	gun.queue_free()
