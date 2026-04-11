class_name Enemy
extends Mob

@export var sword: Area2D
@export var detection_distance: float = 150.0
@export var attack_distance: float = 28.0
@export var knockback_factor: float = 1

var _active: bool
var _knockbacking: bool
var _attacking: float
var _tween: Tween

# Called when ready
func _ready() -> void:
	super()
	speed = 100.0
	sword.attack_finished.connect(_on_attack_finished)

# Called every tick
func _physics_process(delta: float) -> void:
	if _dead or _knockbacking or _attacking:
		move_and_slide()
	else:
		super(delta)

# Updates the direction vector
func _update_direction():
	var distance: Vector2 = PositionController.player_position - position
	if _active:
		sword.rotation = distance.angle() - PI
		if distance.length() < attack_distance:
			_direction = Vector2.ZERO
			_attack()
		else:
			_direction = distance.normalized()
	elif distance.length() < detection_distance:
		_active = true

# Updates the sprite animation
func _update_animation():
	if _direction.length() > 0:
		animation.play("run")
		animation.flip_h = _direction.x < 0
	else:
		animation.play("idle")

# Performs an attack
func _attack():
	_attacking = true
	sword.attack()

func _on_attack_finished():
	_attacking = false

# Lowers health
func take_hit(damage: int, push := Vector2.ZERO):
	super(damage, push)
	if not _dead:
		_active = true

# Performs damage effects
func _damage_effect(_damage: int, push := Vector2.ZERO):
	# Start effects
	_knockbacking = true
	animation.play("idle")
	velocity = push * knockback_factor
	modulate = Constants.DAMAGE_COLOR
	# End effects
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "velocity", Vector2.ZERO, damage_effect_time)
	_tween.tween_property(self, "modulate", Color.WHITE, damage_effect_time)
	_tween.finished.connect(_end_knockback)

func _end_knockback():
	_knockbacking = false

# Kills the enemy
func _die():
	_dead = true
	velocity = Vector2.ZERO
	modulate = Constants.DAMAGE_COLOR
	animation.play("die")
	animation.animation_finished.connect(queue_free)
