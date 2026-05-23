extends Control

@onready var back_button: Button = $GlobalContainer/BackButton


func _ready() -> void:
	back_button.pressed.connect(_back_to_menu, CONNECT_ONE_SHOT)
	back_button.grab_focus.call_deferred()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_back_to_menu()


func _back_to_menu() -> void:
	queue_free()
