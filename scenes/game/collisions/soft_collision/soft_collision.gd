class_name SoftCollision
extends Area2D

# Exported variables
@export var weight: float = 1.0

# Public variables
var push_vector: Vector2 = Vector2.ZERO

# Called when ready
func _ready() -> void:
	add_to_group("soft_collisions")

# Called every tick
func _physics_process(_delta: float) -> void:
	_update_push_vector()

# Updates push vector
func _update_push_vector() -> void:
	var body := _get_first_overlapping_area()
	push_vector = _calculate_push(body) if body else Vector2.ZERO

# Obtains the first overlapping soft collision area
func _get_first_overlapping_area() -> SoftCollision:
	var areas := get_overlapping_areas()
	if areas.size() > 0:
		var area: SoftCollision = areas[0]
		if area.is_in_group("soft_collisions"):
			return area
	return null

# Calculates the push vector
func _calculate_push(body: SoftCollision) -> Vector2:
	var new_vector := body.global_position.direction_to(global_position)
	new_vector = new_vector.normalized() * 1000
	new_vector = new_vector * body.weight / weight
	return new_vector
