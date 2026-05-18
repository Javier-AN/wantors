class_name Gun
extends Node2D
## A 2D node that generates bullets in the direction it is pointing.

#region Variables
## Position in which the bullets are generated.
@export var muzzle: Marker2D
## Bullet scene.
@export var bullet_scene: PackedScene
## Minumum time between two bullet generations expressed in seconds.
@export var shooting_cooldown: float = 0.1
## Speed of the generated bullets.
@export var bullet_speed: float = 250.0
## Damage of the generated bullets.
@export var bullet_damage: int = 5
## Knockback factor of the generated bullets.
@export var bullet_knockback_factor: float = 0.1

## Indicates whether the gun is in cooldown state.
var in_cooldown: bool

# Shooting cooldown timer.
@onready var _timer := Timer.new()
# Static node which functions as parent for bullets.
@onready var _bullet_container := Node2D.new()
#endregion


# Called when ready
func _ready() -> void:
	add_child(_timer)
	_bullet_container.top_level = true
	add_child(_bullet_container)


## Shoots a bullet.
func shoot():
	if not in_cooldown and muzzle:
		_generate_bullet()
		in_cooldown = true
		_timer.start(shooting_cooldown)
		_timer.timeout.connect(_end_cooldown)


# Sets cooldown state to false.
func _end_cooldown() -> void:
	in_cooldown = false


# Generates a bullet and sets its properties.
func _generate_bullet():
	var bullet: BulletArea = bullet_scene.instantiate()
	# Direction of the bullet depends on where the gun is pointing
	bullet.transform = muzzle.global_transform
	bullet.velocity = Vector2.from_angle(bullet.transform.get_rotation())
	bullet.velocity *= bullet_speed
	# The velocity is relative to its origin
	bullet.velocity += owner.velocity
	# Other stats
	bullet.damage = bullet_damage
	bullet.knockback_factor = bullet_knockback_factor
	# Add bullet to tree
	_bullet_container.add_child(bullet)
