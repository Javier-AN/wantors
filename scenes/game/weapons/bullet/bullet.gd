class_name Bullet
extends Area2D
## A moving 2D area that applies damage to a mob upon collision with it.

## Damage the bullet does to a mob on hit.
var damage: int
## Velocity vector which describes the movement of the bullet.
var velocity: Vector2
## Factor by which velocity is multiplied to apply knockback.
var knockback_factor: float


# Called when ready
func _ready():
	body_entered.connect(_on_collision)


# Called every tick
func _physics_process(delta: float):
	position += velocity * delta


# Called when a collision is detected
func _on_collision(body: Node2D):
	var parent := body.get_parent()
	if parent is Mob:
		parent.take_hit(damage, velocity * knockback_factor)
	queue_free()
