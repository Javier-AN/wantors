@abstract
class_name Mob
extends CharacterBody2D
## A character body 2D with specialized health and movement behaviour.

## Emitted when the mob health reaches zero.
signal died

## Soft collision body.
@export var soft_collision: SoftCollision
## Maximum health the mob can have.
@export var max_health: int
## Speed at which the mob moves.
@export var speed: float
## Time the damage effects last, like knockback or invincibility. 
@export var damage_effect_time: float

## Current health.
@onready var health: int = max_health

#region Private variables
var _direction: Vector2 = Vector2.ZERO
var _dead: bool = false
var _timers: Dictionary = {}
#endregion


# Called every tick
func _physics_process(delta: float) -> void:
	_update_timers(delta)
	_update_direction()
	_update_velocity(delta)
	_update_animation()
	move_and_slide()


# Updates the timers
func _update_timers(delta) -> void:
	for key in _timers:
		_timers[key] += delta


## Updates the direction vector.
@abstract func _update_direction() -> void


# Updates the movement velocity
func _update_velocity(delta: float) -> void:
	velocity = _direction * speed
	if soft_collision:
		velocity += soft_collision.push_vector * delta


## Updates the sprite animation.
@abstract func _update_animation() -> void


# Updates health
func _update_health(new_health: int):
	health = new_health
	if health > max_health:
		health = max_health
	if health <= 0:
		_die()


## Manages a received hit.
## 
## [param damage] is the amount of damage received.
## [param push] is the push vector of the hit.
func take_hit(damage: int, push := Vector2.ZERO):
	if not _dead:
		_update_health(health - damage)
	if not _dead:
		_do_damage_effects(damage, push)


# Performs damage effects such as knockbacking or showing visual clues
func _do_damage_effects(_damage: int, _push := Vector2.ZERO):
	modulate = Constants.DAMAGE_COLOR
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, damage_effect_time)


# Called when health reaches zero
func _die():
	_dead = true
	died.emit()
