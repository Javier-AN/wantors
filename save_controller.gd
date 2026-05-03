class_name SaveController
extends Node

@export var game_data: GameData

var _path: String = "user://save.tres"


func save_game_data():
	game_data.unlocked_items = ItemCollectionController.unlocked_items
	ResourceSaver.save(game_data, _path)


func load_game_data():
	if ResourceLoader.exists(_path):
		game_data = load(_path)
	else:
		game_data.unlocked_items = [0, 1]
	ItemCollectionController.unlocked_items = game_data.unlocked_items
