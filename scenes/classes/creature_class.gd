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
## Time the hit effects last. 
@export var hit_time: float
## Color the sprites turn during a hit.
@export var hit_color: Color = Constants.HIT_COLOR
## If set, they turn hit color during a hit. 
@export var sprites: Array[CanvasItem]

## Indicates whether the enemy is dead.
var dead: bool = false
# Hit tween.
var _hit_tween: Tween

## Current health.
@onready var health: int = max_health
# Hit timer.
@onready var _hit_timer := Timer.new()
# Solid color material.
@onready var _solid_color_material: ShaderMaterial = load("res://textures/solid_color_material.tres").duplicate()
#endregion


#region Methods

# Called when ready.
func _ready() -> void:
	_hit_timer.timeout.connect(_hit_ended)
	add_child(_hit_timer)
	_set_solid_color(Color.TRANSPARENT)
	for sprite in sprites:
		sprite.material = _solid_color_material


## Manages a received hit.
## 
## [param damage] is the amount of damage received.
## [param push] is the push vector of the hit.
func take_hit(damage: int, push := Vector2.ZERO) -> void:
	_update_health(health - damage)
	_animate_hit_color()
	if not dead:
		_hit_taken(damage, push)


# Updates health.
func _update_health(new_health: int) -> void:
	if dead:
		return
	health = new_health
	if health > max_health:
		health = max_health
	if health <= 0:
		health = 0
		_die()


# Called when a hit is taken.
func _hit_taken(_damage: int, _push := Vector2.ZERO) -> void:
	_hit_timer.start(hit_time)


# Called after the hit ends.
func _hit_ended() -> void:
	pass


# Called when health reaches zero.
func _die() -> void:
	dead = true
	died.emit()


# Emits a signal and eliminates the node.
func _disappear() -> void:
	disappeared.emit()
	queue_free()


# Toggles on or off the hit color effect.
func _toggle_hit_color(active: bool) -> void:
	_set_solid_color(hit_color if active else Color.TRANSPARENT)


# Animates the hit color.
func _animate_hit_color() -> void:
	if _hit_tween:
		_hit_tween.kill()
	_hit_tween = create_tween()
	_hit_tween.tween_method(_set_solid_color, hit_color, Color(hit_color, 0.0), hit_time)


# Sets the solid color parameter of the shader material.
func _set_solid_color(value: Color):
	_solid_color_material.set_shader_parameter("solid_color", value)

#endregion
