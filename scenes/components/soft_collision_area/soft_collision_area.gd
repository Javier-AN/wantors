## A 2D area that repulses itself away from others of the same kind.
class_name SoftCollisionArea
extends Area2D


## When two soft collision nodes are too close, their weight difference decides
## how much each of them must be pushed away.
@export var weight: float = 1.0


## A velocity vector that describes the current push force that should be
## applied in order to repulse away from other soft collision nodes.
var push_vector: Vector2 = Vector2.ZERO


# Called every tick
func _physics_process(_delta: float) -> void:
	_update_push_vector()


# Updates push vector
func _update_push_vector() -> void:
	var body := _get_first_overlapping_area()
	push_vector = _calculate_push(body) if body else Vector2.ZERO


# Obtains the first overlapping soft collision area
func _get_first_overlapping_area() -> SoftCollisionArea:
	var areas := get_overlapping_areas()
	if areas.size() > 0:
		var first_area := areas[0]
		if first_area is SoftCollisionArea:
			return first_area
	return null


# Calculates the push vector
func _calculate_push(body: SoftCollisionArea) -> Vector2:
	var new_vector := body.global_position.direction_to(global_position)
	new_vector = new_vector.normalized() * 2000
	new_vector = new_vector * body.weight / weight
	return new_vector
