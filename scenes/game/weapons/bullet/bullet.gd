class_name  Bullet
extends Area2D

var damage: int
var velocity: Vector2
var knockback_factor: float

# Called when ready
func _ready():
	body_entered.connect(_on_collision)

# Called every tick
func _physics_process(delta: float):
	position += velocity * delta

# Called when a collision is detected
func _on_collision(body: Node2D):
	if body.get_parent().is_in_group("mobs"):
		body.get_parent().take_hit(damage, velocity * knockback_factor)
	queue_free()
