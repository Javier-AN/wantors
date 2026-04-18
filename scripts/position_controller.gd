extends Node


## Emitted when player position is updated.
signal position_updated


## Current player position.
var player_position: Vector2


## Updates the player position.
func update_position(new_position):
	player_position = new_position
	position_updated.emit(player_position)
