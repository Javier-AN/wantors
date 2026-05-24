extends Control

@onready var menu_container: Control = $MenuContainer
@onready var main_container: Control = $MainContainer
@onready var first_button: Button = $MainContainer/PlayButton
@onready var collection_button: Button = $MainContainer/ItemCollectionButton
@onready var settings_button: Button = $MainContainer/SettingsButton
@onready var credits_button: Button = $MainContainer/CreditsButton
@onready var exit_button: Button = $MainContainer/ExitButton
@onready var music_player: AudioStreamPlayer2D = $MusicPlayer
@onready var collection_scene: PackedScene = load("res://scenes/ui/item_collection_menu/item_collection_menu.tscn")
@onready var settings_scene: PackedScene = load("res://scenes/ui/settings_menu/settings_menu.tscn")
@onready var credits_scene: PackedScene = load("res://scenes/ui/credits_menu/credits_menu.tscn")


func _ready() -> void:
	SaveController.load_game_data()
	SaveController.load_preferences()
	collection_button.pressed.connect(_open_collection)
	settings_button.pressed.connect(_open_settings)
	credits_button.pressed.connect(_open_credits)
	exit_button.pressed.connect(_exit)
	first_button.grab_focus.call_deferred()


func _open_collection() -> void:
	_open_scene(collection_scene)


func _open_settings() -> void:
	_open_scene(settings_scene)


func _open_credits() -> void:
	_open_scene(credits_scene)


func _open_scene(scene: PackedScene) -> void:
	var instance := scene.instantiate()
	main_container.visible = false
	menu_container.add_child(instance)
	instance.tree_exited.connect(_back_to_main)


func _back_to_main() -> void:
	main_container.visible = true
	first_button.grab_focus.call_deferred()


func _exit():
	music_player.free()
	SfxSoundPlayer.free()
	UiSoundPlayer.free()
	get_tree().quit()
