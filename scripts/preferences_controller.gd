extends Node

var preferences: Preferences


func set_preferences(new_preferences: Preferences) -> void:
	preferences = new_preferences
	TranslationServer.set_locale(Constants.LANGS[preferences.language])


func set_language(new_language_index: int) -> void:
	preferences.language = new_language_index
	TranslationServer.set_locale(Constants.LANGS[new_language_index])


func set_sfx_volume(new_volume: int) -> void:
	preferences.sfx_volume = new_volume


func set_music_volume(new_volume: int) -> void:
	preferences.music_volume = new_volume


func set_extended_ui(new_state: bool) -> void:
	preferences.extended_ui = new_state
