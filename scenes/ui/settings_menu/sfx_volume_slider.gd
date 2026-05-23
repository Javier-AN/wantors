class_name SFXVolumeSlider
extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = PreferencesController.preferences.sfx_volume
	grab_focus.call_deferred()


func _value_changed(new_value: float) -> void:
	PreferencesController.set_sfx_volume(new_value)
