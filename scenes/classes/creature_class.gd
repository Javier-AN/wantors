@abstract
class_name Creature
extends CharacterBody2D
## A character body 2D that has health and can die.

#region Signals
## Emitted when the mob health reaches zero.
signal died
## Emitted when the mob finishes its death animation.
signal disappeared
#endregion

#region Variables
## Maximum health the mob can have.
@export var max_health: int
## Time the damage effects last, like knockback or invincibility. 
@export var damage_effect_time: float

## Indicates whether the enemy is dead.
var dead: bool = false

## Current health.
@onready var health: int = max_health
#endregion


#region Methods

## Manages a received hit.
## 
## [param damage] is the amount of damage received.
## [param push] is the push vector of the hit.
func take_hit(damage: int, push := Vector2.ZERO) -> void:
	_update_health(health - damage)
	if not dead:
		_do_damage_effects(damage, push)


# Updates health
func _update_health(new_health: int) -> void:
	if dead:
		return
	health = new_health
	if health > max_health:
		health = max_health
	if health <= 0:
		health = 0
		_die()


# Performs damage effects such as knockbacking or showing visual clues.
func _do_damage_effects(_damage: int, _push := Vector2.ZERO) -> void:
	modulate = Constants.DAMAGE_COLOR
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, damage_effect_time)


# Called when health reaches zero.
func _die() -> void:
	dead = true
	died.emit()


# Emits a signal and eliminates the node.
func _disappear() -> void:
	disappeared.emit()
	queue_free()

#endregion
