extends Control

@onready var menu_container: Control = $MenuContainer
@onready var main_container: Control = $MainContainer
@onready var collection_button: Button = $MainContainer/ItemCollectionButton
@onready var settings_button: Button = $MainContainer/SettingsButton
@onready var collection_scene: PackedScene = load("res://scenes/ui/item_collection_menu/item_collection_menu.tscn")
@onready var settings_scene: PackedScene = load("res://scenes/ui/settings_menu/settings_menu.tscn")


func _ready() -> void:
	SaveController.load_game_data()
	SaveController.load_preferences()
	collection_button.pressed.connect(_open_collection)
	settings_button.pressed.connect(_open_settings)


func _open_collection() -> void:
	var collection := collection_scene.instantiate()
	main_container.visible = false
	menu_container.add_child(collection)
	collection.tree_exited.connect(_turn_visibility_on)


func _open_settings() -> void:
	var settings := settings_scene.instantiate()
	main_container.visible = false
	menu_container.add_child(settings)
	settings.tree_exited.connect(_turn_visibility_on)


func _turn_visibility_on() -> void:
	main_container.visible = true
