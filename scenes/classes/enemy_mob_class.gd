@abstract
class_name EnemyMob
extends Mob
## A mob that receives knockback.

## Factor by which velocity is multiplied to apply knockback.
@export var knockback_factor: float

var _knockbacking: bool = false
var _tween: Tween


# Called every tick
func _physics_process(delta: float) -> void:
	if dead or _knockbacking:
		move_and_slide()
	else:
		super(delta)


# Performs damage effects such as knockbacking or showing visual clues
func _do_damage_effects(_damage: int, push := Vector2.ZERO):
	# Start effects
	_knockbacking = true
	velocity = push * knockback_factor
	modulate = Constants.DAMAGE_COLOR
	# End effects
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "velocity", Vector2.ZERO, damage_effect_time)
	_tween.tween_property(self, "modulate", Color.WHITE, damage_effect_time)
	_tween.finished.connect(_end_knockback)


# Puts the enemy in not-knockbaking state
func _end_knockback():
	_knockbacking = false
