extends BulletArea

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	_sprite.play("travel")


func _self_destroy() -> void:
	velocity = Vector2.ZERO
	_sprite.play("hit")
	_sprite.animation_finished.connect(queue_free)
