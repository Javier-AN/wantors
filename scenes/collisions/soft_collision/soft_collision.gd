class_name SoftCollision
extends Area2D

var push_vector: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	_update_push_vector()

func _update_push_vector() -> void:
	var areas := get_overlapping_areas()
	if areas.size() > 0:
		var area := areas[0]
		push_vector = area.global_position.direction_to(global_position).normalized()
	else:
		push_vector = Vector2.ZERO
