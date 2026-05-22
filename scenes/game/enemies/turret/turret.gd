class_name Turret
extends Creature
## An AI controlled enemy mob that follows the player around.

## Enemy sprite.
@onready var _sprite: AnimatedSprite2D = $Sprite
## Enemy gun.
@onready var _gun: EnemyGun = $Gun
## Hitbox for receicing damage.
@onready var _damage_body: StaticBody2D = $DamageCollisionBody
# Indicates if the node is flipped horizontally.
@onready var _flipped: bool = global_position.x > 0


# Called when ready.
func _ready() -> void:
	super()
	if _flipped:
		scale = Vector2(-scale.x, scale.y)


# Called every tick.
func _physics_process(_delta: float) -> void:
	if _gun:
		var distance := PositionController.player_position - position
		_gun.direction.x = -distance.x if _flipped else distance.x
		_gun.direction.y = distance.y


# Called when a hit is taken.
func _hit_taken(damage: int, push := Vector2.ZERO) -> void:
	super(damage, push)
	_sprite.play("hit")


# Called when health reaches zero.
func _die():
	super()
	# First disable collisions
	if _damage_body:
		_damage_body.queue_free()
	if _gun:
		_gun.queue_free()
	# Then animate
	velocity = Vector2.ZERO
	_sprite.play("die")
	# Finally erase
	_sprite.animation_finished.connect(_disappear)
