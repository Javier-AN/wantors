class_name FullScreenCheckButton
extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_pressed = PreferencesController.preferences.full_screen


# Called when pressed.
func _toggled(toggled_on: bool) -> void:
	PreferencesController.set_full_screen(toggled_on)
