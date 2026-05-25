extends Control

@onready var back_button: Button = $GlobalContainer/BackButton


func _ready() -> void:
	back_button.pressed.connect(_save_and_exit, CONNECT_ONE_SHOT)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_save_and_exit()


func _save_and_exit() -> void:
	SaveController.save_preferences()
	queue_free()
