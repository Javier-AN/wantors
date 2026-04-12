class_name Mob
extends CharacterBody2D

# Signals
signal died

# Nodes
@export var animation: AnimatedSprite2D
@export var soft_collision: SoftCollision

# Exported variables
@export var max_health: int = 20
@export var speed: float = 120.0
@export var damage_effect_time: float = 0.2

# Public variables
var health: int

# Private variables
var _direction: Vector2 = Vector2.ZERO
var _dead: bool = false
var _timers: Dictionary = {}

# Called when ready
func _ready() -> void:
	add_to_group("mobs")
	health = max_health

# Called every tick
func _physics_process(delta: float) -> void:
	_update_timers(delta)
	_update_direction()
	_update_velocity(delta)
	_update_animation()
	move_and_slide()

# Updates the timers
func _update_timers(delta):
	for key in _timers:
		_timers[key] += delta

# Updates the direction vector
func _update_direction():
	pass

# Updates the movement velocity
func _update_velocity(delta: float):
	velocity = _direction * speed
	if soft_collision:
		velocity += soft_collision.push_vector * delta

# Updates the sprite animation
func _update_animation():
	pass

# Updates health
func _update_health(new_health: int = health, new_max_health: int = max_health):
	max_health = new_max_health
	health = new_health
	if health > max_health:
		health = max_health
	if health <= 0:
		_die()

# Manages a received hit
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
