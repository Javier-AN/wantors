extends Node

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
	pause_menu_visible = value
	_update()


## Forces the game to be unpaused.
## Should only be used right before exiting the game scene.
func force_quit() -> void:
	game_paused = false
	pause_menu_visible = false
	_update()


func _update() -> void:
	get_tree().paused = game_paused or pause_menu_visible
