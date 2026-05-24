class_name AttackArea
extends Area2D
## A 2D area that applies damage to a creature upon collision with it.

## Damage the area applies to a creature on hit.
@export var damage: int


# Called when ready.
func _physics_process(_delta: float) -> void:
	if has_overlapping_bodies():
		var target := get_overlapping_bodies()[0].get_parent()
		if target is Creature:
			hit(target)


## Performs a hit on the [param target] creature.
func hit(target: Creature) -> void:
	target.take_hit(damage)
