extends Node

signal position_updated

var player_position: Vector2

func update_position(new_position):
	player_position = new_position
	position_updated.emit(player_position)
