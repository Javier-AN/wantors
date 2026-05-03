extends Control

@onready var save_controller: SaveController = $SaveController


# Called when ready
func _ready() -> void:
	save_controller.load_game_data()
