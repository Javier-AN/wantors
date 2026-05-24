extends Node

## Emitted when player position is updated.
signal position_updated
## Emitted when player moving direction is updated.
signal direction_updated


## Current player position.
var player_position := Vector2.ZERO
var player_direction := Vector2.ZERO


## Updates the player position.
func update_position(new_position):
	player_position = new_position
	position_updated.emit(player_position)


## Updates the player direction.
func update_direction(new_direction):
	player_direction = new_direction
	direction_updated.emit(player_direction)
