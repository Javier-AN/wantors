extends Node

var preferences: Preferences


func set_preferences(new_preferences: Preferences) -> void:
	preferences = new_preferences
	TranslationServer.set_locale(Constants.LANGS[preferences.language])
	_set_bus_volume("SFX", preferences.sfx_volume)
	_set_bus_volume("Music", preferences.music_volume)
	var value := DisplayServer.WINDOW_MODE_FULLSCREEN if new_preferences.full_screen else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(value)


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


func set_full_screen(new_state: bool) -> void:
	preferences.full_screen = new_state
	var value := DisplayServer.WINDOW_MODE_FULLSCREEN if new_state else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(value)


func _set_bus_volume(bus_name: String, volume: float) -> void:
	var index := AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_linear(index, volume)
		
	
