class_name PauseMenu
extends Control

@onready var _resume_button: Button = $GlobalContainer/ResumeButton
@onready var _exit_button: Button = $GlobalContainer/ExitButton
@onready var menu_scene: PackedScene = load("res://scenes/ui/main_menu/main_menu.tscn")


# Called when ready.
func _ready() -> void:
	visible = PauseController.pause_menu_visible
	_resume_button.pressed.connect(_resume)
	_exit_button.pressed.connect(_exit)


# Called when an input is received.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		PauseController.toggle_menu()
		visible = PauseController.pause_menu_visible
		_resume_button.grab_focus.call_deferred()
	elif event.is_action_pressed("ui_cancel"):
		_resume()


# Unpauses the game.
func _resume() -> void:
	PauseController.toggle_menu(false)
	visible = false


# Changes the scene to the main menu.
func _exit() -> void:
	var menu := menu_scene.instantiate()
	PauseController.force_quit()
	get_parent().get_parent().add_sibling(menu)
	get_parent().get_parent().queue_free()
