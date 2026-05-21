@abstract
class_name EnemyMob
extends Mob
## A mob that receives knockback.

## Factor by which velocity is multiplied to apply knockback.
@export var knockback_factor: float

var _knockbacking: bool = false
var _knockback_tween: Tween


# Called every tick
func _physics_process(delta: float) -> void:
	if dead or _knockbacking:
		move_and_slide()
	else:
		super(delta)


# Called when a hit is taken.
func _hit_taken(damage: int, push := Vector2.ZERO) -> void:
	super(damage, push)
	_knockbacking = true
	if _knockback_tween:
		_knockback_tween.kill()
	velocity = push * knockback_factor
	_knockback_tween = create_tween()
	_knockback_tween.tween_property(self, "velocity", Vector2.ZERO, hit_time)


# Called when a hit ends.
func _hit_ended() -> void:
	super()
	_knockbacking = false
