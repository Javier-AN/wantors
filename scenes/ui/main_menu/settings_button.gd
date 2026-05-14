extends Button


@onready var settings_scene: PackedScene = load("res://scenes/ui/settings_menu/settings_menu.tscn")


func _ready() -> void:
	pressed.connect(_go_to_settings, CONNECT_ONE_SHOT)


func _go_to_settings() -> void:
	var settings := settings_scene.instantiate()
	get_parent().get_parent().add_sibling(settings)
	get_parent().get_parent().queue_free()
