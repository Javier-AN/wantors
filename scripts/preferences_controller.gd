extends Node

var preferences: Preferences


func set_preferences(new_preferences: Preferences) -> void:
	preferences = new_preferences
	TranslationServer.set_locale(Constants.LANGS[preferences.language])
	_set_bus_volume("SFX", preferences.sfx_volume)
	_set_bus_volume("Music", preferences.music_volume)


func set_language(new_language_index: int) -> void:
	preferences.language = new_language_index
	TranslationServer.set_locale(Constants.LANGS[new_language_index])


func set_sfx_volume(new_volume: float) -> void:
	preferences.sfx_volume = new_volume
	_set_bus_volume("SFX", new_volume)


func set_music_volume(new_volume: float) -> void:
	preferences.music_volume = new_volume
	_set_bus_volume("Music", new_volume)


func set_extended_ui(new_state: bool) -> void:
	preferences.extended_ui = new_state


func _set_bus_volume(bus_name: String, volume: float) -> void:
	var index := AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_linear(index, volume)
		
	
