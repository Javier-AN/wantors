extends Control


# Called when ready
func _ready() -> void:
	SaveController.load_game_data()
	SaveController.load_preferences()
