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
@export var hit_color: Color = Constants.DAMAGE_COLOR
## If set, they turn hit color during a hit. 
@export var sprites: Array[CanvasItem]

## Indicates whether the enemy is dead.
var dead: bool = false

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
	_solid_color_material.set_shader_parameter("solid_color", hit_color)


## Manages a received hit.
## 
## [param damage] is the amount of damage received.
## [param push] is the push vector of the hit.
func take_hit(damage: int, push := Vector2.ZERO) -> void:
	_update_health(health - damage)
	_toggle_hit_color(true)
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
	_toggle_hit_color(false)


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
	if not sprites:
		return
	var value: ShaderMaterial = _solid_color_material if active else null
	for sprite in sprites:
		sprite.material = value

#endregion
