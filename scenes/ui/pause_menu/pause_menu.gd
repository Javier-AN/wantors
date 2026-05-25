extends Control

@onready var main_container: Control = $MainContainer
@onready var menu_container: Control = $MenuContainer
@onready var resume_button: Button = $MainContainer/ResumeButton
@onready var settings_button: Button = $MainContainer/SettingsButton
@onready var exit_button: Button = $MainContainer/ExitButton
@onready var settings_scene: PackedScene = load("res://scenes/ui/settings_menu/settings_menu.tscn")
@onready var menu_scene: PackedScene = load("res://scenes/ui/main_menu/main_menu.tscn")


# Called when ready.
func _ready() -> void:
	visible = PauseController.pause_menu_visible
	resume_button.pressed.connect(_resume)
	settings_button.pressed.connect(_open_settings)
	exit_button.pressed.connect(_exit)


# Called when an input is received.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		PauseController.toggle_menu()
		visible = PauseController.pause_menu_visible
		if visible:
			resume_button.grab_focus.call_deferred()
	elif event.is_action_pressed("ui_cancel"):
		_resume()


# Unpauses the game.
func _resume() -> void:
	PauseController.toggle_menu(false)
	visible = false


func _open_settings() -> void:
	var instance := settings_scene.instantiate()
	main_container.visible = false
	menu_container.add_child(instance)
	instance.tree_exited.connect(_back_to_main)


func _back_to_main() -> void:
	main_container.visible = true
	resume_button.grab_focus.call_deferred()


# Changes the scene to the main menu.
func _exit() -> void:
	var menu := menu_scene.instantiate()
	PauseController.force_quit()
	get_parent().get_parent().add_sibling(menu)
	get_parent().get_parent().queue_free()
