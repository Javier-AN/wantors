class_name ExtendedUICheckButton
extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_pressed = PreferencesController.preferences.extended_ui


# Called when pressed.
func _toggled(toggled_on: bool) -> void:
	PreferencesController.set_extended_ui(toggled_on)
