class_name HitArea
extends Area2D
## A 2D area that applies damage to a creature upon collision with it.

## Damage the area applies to a creature on hit.
var damage: int


# Called when ready.
func _ready() -> void:
	body_entered.connect(_on_collision)


# Called when a collision is detected.
func _on_collision(body: Node2D) -> void:
	var parent := body.get_parent()
	if parent is Creature:
		hit(parent)
	queue_free()


## Performs a hit on the [param target] creature.
func hit(target: Creature) -> void:
	target.take_hit(damage)
