class_name Mob
extends CharacterBody2D

# Exports
@export var animation: AnimatedSprite2D
@export var soft_collision: SoftCollision

@export var max_health: int = 20
@export var speed: float = 120.0
@export var damage_effect_time: float = 0.2
@export var soft_collision_weight: float = 1.0

# Private variables
var _health: int
var _direction: Vector2 = Vector2.ZERO
var _dead: bool = false
var _timers: Dictionary = {}

# Called when ready
func _ready() -> void:
	add_to_group("mobs")
	_health = max_health

# Called every tick
func _physics_process(delta: float) -> void:
	_update_timers(delta)
	_update_direction()
	_update_velocity(delta)
	_update_animation()
	move_and_slide()

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
		velocity += soft_collision.push_vector * delta * 1000 / soft_collision_weight

# Updates the sprite animation
func _update_animation():
	pass

# Lowers health
func take_hit(damage: int, push := Vector2.ZERO):
	if not _dead:
		_health -= damage
		if _health > 0:
			_damage_effect(damage, push)
		else:
			_die()

# Performs damage effects
func _damage_effect(_damage: int, _push := Vector2.ZERO):
		modulate = Constants.DAMAGE_COLOR
		var tween: Tween = create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, damage_effect_time)

# Called when health reaches zero
func _die():
	_dead = true
