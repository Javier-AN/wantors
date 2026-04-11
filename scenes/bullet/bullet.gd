class_name  Bullet
extends Area2D

var damage: int = 5
var velocity: Vector2
var knockback_factor: float = 0.1

# Called when ready
func _ready():
	body_entered.connect(_on_collision)

# Called every tick
func _physics_process(delta):
	position += velocity * delta

# Called when a collision is detected
func _on_collision(body):
	if body.get_parent().is_in_group("mobs"):
		body.get_parent().take_hit(damage, velocity * knockback_factor)
	queue_free()
