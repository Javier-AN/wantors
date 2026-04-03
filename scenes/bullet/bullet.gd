class_name  Bullet
extends Node2D

@export var area: Area2D

var velocity: Vector2

func _ready():
	area.body_entered.connect(_on_collision)

func _physics_process(delta):
	position += velocity * delta

func _on_collision(body):
	print(body)
	if body.is_in_group("mobs"):
		# TODO: do damage
		print("hit")
	queue_free()
