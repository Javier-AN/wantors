extends Button


@onready var menu_scene: PackedScene = load("res://scenes/ui/main_menu/main_menu.tscn")


func _ready() -> void:
	pressed.connect(_save_and_exit, CONNECT_ONE_SHOT)


func _save_and_exit() -> void:
	SaveController.save_preferences()
	var menu = menu_scene.instantiate()
	get_parent().get_parent().add_sibling(menu)
	get_parent().get_parent().queue_free()
