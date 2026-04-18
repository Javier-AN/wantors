class_name Sword
extends Area2D


## Emitted after an attack is performed.
signal attack_finished


## Sword sprite.
@export var sprite: Sprite2D
## Damage the sword does to a mob on hit.
@export var damage: int = 5
## Minumum time between two attacks expressed in seconds.
@export var attack_cooldown: float = 0.6
## Time it takes to perform an attack.
@export var attack_time: float = 0.4


# Called when ready
func _ready():
	body_entered.connect(_on_collision)


# Called every tick
func _physics_process(_delta: float) -> void:
	_update_sword_flip()


# Called when a collision is detected
func _on_collision(body):
	if body.get_parent().is_in_group("mobs"):
		body.get_parent().take_hit(damage)


func _update_sword_flip():
	sprite.flip_v = not Utils.is_facing_right(rotation)


## Performs an attack.
func attack():
	_animate_turn(attack_time, _recovery)


# Goes back to the standard position after an attack
func _recovery():
	_animate_turn(attack_cooldown, attack_finished.emit)


# Performs a 180º rotation animation
func _animate_turn(time: float, callable: Callable):
	var angle = PI if Utils.is_facing_right(rotation) else -PI
	var tween: Tween = create_tween()
	tween.tween_property(self, "rotation", rotation + angle, time)
	tween.finished.connect(callable)
