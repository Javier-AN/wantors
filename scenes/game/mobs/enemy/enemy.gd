class_name Enemy
extends Mob
## An AI controlled mob that follows the player around and attacks when close.

#region Public variables
## Enemy sprite.
@export var sprite: AnimatedSprite2D
## Melee weapon carried by the enemy.
@export var sword: Area2D
## Hitbox for receicing damage.
@export var damage_body: StaticBody2D
## When a player enters this area, the enemy activates.
@export var detection_area: Area2D
## Distance from the player at which an attack is triggered.
@export var attack_distance: float
## Factor by which velocity is multiplied to apply knockback.
@export var knockback_factor: float
#endregion

#region Private variables
var _active: bool = true
var _knockbacking: bool = false
var _attacking: float = false
var _tween: Tween
#endregion


# Called when ready
func _ready() -> void:
	detection_area.body_entered.connect(_activate)
	sword.attack_finished.connect(_on_attack_finished)


# Called every tick
func _physics_process(delta: float) -> void:
	if _dead or _knockbacking or _attacking:
		move_and_slide()
	else:
		super(delta)


# Puts the enemy in active state
func _activate(_body: Node2D) -> void:
	_active = true

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
		sprite.play("run")
		sprite.flip_h = _direction.x < 0
	else:
		sprite.play("idle")


# Performs an attack
func _attack():
	_attacking = true
	sword.attack()


# Called when the sword attack finishes
func _on_attack_finished():
	_attacking = false


# Inherited: Manages a received hit
func take_hit(damage: int, push := Vector2.ZERO):
	super(damage, push)
	if not _dead:
		_active = true


# Performs damage effects such as knockbacking or showing visual clues
func _do_damage_effects(_damage: int, push := Vector2.ZERO):
	# Start effects
	_knockbacking = true
	sprite.play("idle")
	velocity = push * knockback_factor
	modulate = Constants.DAMAGE_COLOR
	# End effects
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "velocity", Vector2.ZERO, damage_effect_time)
	_tween.tween_property(self, "modulate", Color.WHITE, damage_effect_time)
	_tween.finished.connect(_end_knockback)


# Puts the enemy in not-knockbaking state
func _end_knockback():
	_knockbacking = false


# Kills the enemy
func _die():
	super()
	# First disable collisions
	damage_body.queue_free()
	# Then animate
	velocity = Vector2.ZERO
	modulate = Constants.DAMAGE_COLOR
	sprite.play("die")
	# Finally erase
	sprite.animation_finished.connect(queue_free)
