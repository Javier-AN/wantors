extends Node

signal paused
signal unpaused
signal pause_menu_closed
signal pause_menu_opened

## Indicates wether the game is paused for a reason other than the pause menu.
var game_paused: bool
## Indicates if the pause menu is visible.
var pause_menu_visible: bool


## Toggles game paused state.
## A certain state can be forced with [param value].
## This function should [b]not[/b] be called by the pause menu. 
func toggle(value: bool = not game_paused) -> void:
	game_paused = value
	_update()


## Toggles game paused state.
## A certain state can be forced with [param value].
## This function should only be called by the pause menu.
func toggle_menu(value: bool = not pause_menu_visible) -> void:
	if value:
		if not pause_menu_visible:
			pause_menu_visible = true
			pause_menu_opened.emit()
	else:
		if pause_menu_visible:
			pause_menu_visible = false
			pause_menu_closed.emit()
	_update()


## Forces the game to be unpaused.
## Should only be used right before exiting the game scene.
func force_quit() -> void:
	game_paused = false
	pause_menu_visible = false
	_update()
	SfxSoundPlayer.reset()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _update() -> void:
	if game_paused or pause_menu_visible:
		if not get_tree().paused:
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			paused.emit()
	else:
		if get_tree().paused:
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			unpaused.emit()
