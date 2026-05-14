class_name PauseMenu
extends Control

@onready var _resume_button: Button = $VBoxContainer/ResumeButton
@onready var _exit_button: Button = $VBoxContainer/ExitButton
@onready var menu_scene: PackedScene = load("res://scenes/ui/main_menu/main_menu.tscn")

var _paused: bool


func _ready() -> void:
	_paused = get_tree().paused
	visible = _paused
	_resume_button.pressed.connect(_toggle_pause)
	_exit_button.pressed.connect(_exit)


# Called when an input is received.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_toggle_pause()


# Pauses or unpauses the game when the pause button is pressed.
func _toggle_pause() -> void:
	_paused = !_paused
	get_tree().paused = _paused
	visible = _paused


func _exit() -> void:
	var menu := menu_scene.instantiate()
	get_tree().paused = false
	get_parent().get_parent().add_sibling(menu)
	get_parent().get_parent().queue_free()
