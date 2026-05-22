extends BulletArea

@onready var _sprite: AnimatedSprite2D = $Sprite
@onready var _collision: CollisionShape2D = $CollisionShape


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if _sprite:
		_sprite.play("travel")
		_sprite.animation_finished.connect(queue_free)


func _self_destroy() -> void:
	velocity = Vector2.ZERO
	if _sprite:
		if _collision:
			_collision.queue_free()
		_sprite.play("hit")
	else:
		queue_free()
