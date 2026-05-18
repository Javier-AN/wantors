class_name BulletArea
extends HitArea
## A moving 2D area that applies damage to a mob upon collision with it.

## Velocity vector which describes the movement of the bullet.
var velocity: Vector2
## Factor by which velocity is multiplied to apply knockback.
var knockback_factor: float


# Called every tick
func _physics_process(delta: float):
	position += velocity * delta


# Called when a collision is detected
func hit(target: Creature) -> void:
	target.take_hit(damage, velocity * knockback_factor)
