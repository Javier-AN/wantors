class_name MusicVolumeSlider
extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = PreferencesController.preferences.music_volume


func _value_changed(new_value: float) -> void:
	PreferencesController.set_music_volume(new_value)
