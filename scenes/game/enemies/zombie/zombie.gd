class_name Zombie
extends EnemyMob
## An AI controlled enemy mob that follows the player around.

## Enemy sprite.
@onready var _sprite: AnimatedSprite2D = $Sprite
## Hitbox for receicing damage.
@onready var _damage_body: StaticBody2D = $DamageCollisionBody
## Hitbox for producing damage.
@onready var _attack_area: AttackArea = $AttackArea


# Called every tick
func _physics_process(delta: float) -> void:
	if dead or _knockbacking:
		move_and_slide()
	else:
		super(delta)


# Updates the direction vector
func _update_direction():
	var distance := PositionController.player_position - position
	if _attack_area and _attack_area.has_overlapping_bodies():
		_direction = Vector2.ZERO
	else:
		_direction = distance.normalized()


# Updates the sprite animation
func _update_animation():
	if _direction.length() > 0:
		_sprite.play("run")
		_sprite.flip_h = _direction.x < 0
	else:
		_sprite.play("idle")


# Called when a hit is taken.
func _hit_taken(damage: int, push := Vector2.ZERO) -> void:
	super(damage, push)
	_sprite.play("hit")


# Called when health reaches zero.
func _die():
	super()
	# First disable collisions
	if _attack_area:
		_attack_area.queue_free()
	if _damage_body:
		_damage_body.queue_free()
	# Then animate
	velocity = Vector2.ZERO
	_sprite.play("die")
	# Finally erase
	_sprite.animation_finished.connect(_disappear)
