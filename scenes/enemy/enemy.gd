class_name Enemy
extends CharacterBody2D

@export var animation: AnimatedSprite2D
@export var sword: Area2D

var detection_distance: float = 150.0
var attack_distance: float = 28.0
var speed: float = 50.0
var health: int = 25
var knockback: float = 0.2
var knockback_time = 0.2

var _active: bool
var _knockbacking: bool
var _dead: bool
var _attacking: float
var _tween: Tween

# Called when ready
func _ready() -> void:
	add_to_group("mobs")
	sword.attack_finished.connect(_on_attack_finished)

# Called every tick
func _physics_process(_delta: float) -> void:
	if not (_dead or _knockbacking or _attacking):
		_update_state()
		_update_animation()
	move_and_slide()

# Checks values and updates properties accordingly
func _update_state():
	var distance: Vector2 = PositionController.player_position - position
	if _active:
		if distance.length() < attack_distance:
			velocity = Vector2.ZERO
			_attack()
		else:
			velocity = distance.normalized() * speed
			sword.rotation = distance.angle() - PI
	elif distance.length() < detection_distance:
		_active = true

# Changes the animation depending on the current state
func _update_animation():
	if velocity.length() > 0:
		animation.play("run")
		animation.flip_h = velocity.x < 0
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
	if not _dead:
		health -= damage
		if health > 0:
			_knockback(push)
		else:
			_die()

# Shows damage effects
func _knockback(push := Vector2.ZERO):
	# Start effects
	_knockbacking = true
	animation.play("damage")
	velocity = push * knockback
	modulate = Constants.DAMAGE_COLOR
	# End effects
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "velocity", Vector2.ZERO, knockback_time)
	_tween.tween_property(self, "modulate", Color.WHITE, knockback_time)
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
