extends Node

@onready var _game_data: GameData = load("res://resources/game_data.tres")
@onready var _preferences: Preferences = load("res://resources/preferences.tres")

var _game_data_path: String = "user://save.tres"
var _preferences_path: String = "user://preferences.tres"


func save_game_data():
	_game_data.unlocked_items = ItemCollectionController.unlocked_items
	ResourceSaver.save(_game_data, _game_data_path)


func load_game_data():
	if ResourceLoader.exists(_game_data_path):
		_game_data = load(_game_data_path)
	ItemCollectionController.unlocked_items = _game_data.unlocked_items


func save_preferences():
	_preferences = PreferencesController.preferences
	ResourceSaver.save(_preferences, _preferences_path)


func load_preferences():
	if ResourceLoader.exists(_preferences_path):
		_preferences = load(_preferences_path)
	PreferencesController.set_preferences(_preferences)
