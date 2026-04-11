class_name Enemy
extends Mob

# Nodes
@export var sword: Area2D
@export var detection_area: Area2D

# Exported variables
@export var attack_distance: float = 28.0
@export var knockback_factor: float = 1

# Private variables
var _active: bool = true
var _knockbacking: bool = false
var _attacking: float = false
var _tween: Tween

# Called when ready
func _ready() -> void:
	super()
	detection_area.body_entered.connect(_activate)
	sword.attack_finished.connect(_on_attack_finished)

func _activate(_body: Node2D) -> void:
	_active = true

# Called every tick
func _physics_process(delta: float) -> void:
	if _dead or _knockbacking or _attacking:
		move_and_slide()
	else:
		super(delta)

# Updates the direction vector
func _update_direction():
	if _active:
		var distance := PositionController.player_position - position
		sword.rotation = distance.angle() - PI
		if distance.length() < attack_distance:
			_direction = Vector2.ZERO
			_attack()
		else:
			_direction = distance.normalized()

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
	super()
	velocity = Vector2.ZERO
	modulate = Constants.DAMAGE_COLOR
	animation.play("die")
	animation.animation_finished.connect(queue_free)
