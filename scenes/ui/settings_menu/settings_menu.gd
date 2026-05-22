extends Control

@onready var back_button: Button = $GlobalContainer/BackButton
@onready var menu_scene: PackedScene = load("res://scenes/ui/main_menu/main_menu.tscn")


func _ready() -> void:
	back_button.pressed.connect(_save_and_exit, CONNECT_ONE_SHOT)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_save_and_exit()


func _save_and_exit() -> void:
	SaveController.save_preferences()
	var menu = menu_scene.instantiate()
	add_sibling(menu)
	queue_free()
