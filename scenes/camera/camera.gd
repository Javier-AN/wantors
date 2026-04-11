extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = PositionController.player_position
	PositionController.position_updated.connect(_update_position)

func _update_position(player_position: Vector2):
	global_position = player_position
