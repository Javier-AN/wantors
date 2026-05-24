@abstract
class_name Mob
extends Creature
## A creature that moves by itself.

#region Variables
## If set, its soft collision force will be applied to the mob.
@export var soft_collision_area: SoftCollisionArea
## Speed at which the mob moves.
@export var speed: float

var _direction := Vector2.ZERO
#endregion


#region Methods

# Called every tick
func _physics_process(delta: float) -> void:
	if not dead:
		_update_direction()
		_update_velocity(delta)
		_update_animation()
		move_and_slide()


## Updates the direction vector.
@abstract func _update_direction() -> void
## Updates the sprite animation.
@abstract func _update_animation() -> void


# Updates the movement velocity
func _update_velocity(delta: float) -> void:
	velocity = _direction * speed
	if soft_collision_area:
		velocity += soft_collision_area.push_vector * delta

#endregion
