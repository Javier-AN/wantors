class_name Camera
extends Camera2D
## A 2D camera that follows the player.


# Called when ready
func _ready() -> void:
	global_position = PositionController.player_position
	PositionController.position_updated.connect(_update_position)


# Updates camera position to follow the player
func _update_position(player_position: Vector2):
	global_position = player_position
