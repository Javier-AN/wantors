@abstract
class_name Item
extends Control
## A choosable item that modifies player stats.

## Emitted when the effect is applied.
signal effect_applied
## Emitted when the button is pressed.
signal pressed

## Item control.
@export var item_control: ItemControl
## If true, the item will be a button. If false, it will be a panel.
@export var clickable: bool = true:
	set(value):
		clickable = value
		if button:
			_update_button_mouse_filter()
## Indicates if the item is locked.
@export var locked: bool = false:
	set(value):
		locked = value
		mouse_filter = MOUSE_FILTER_IGNORE if locked else MOUSE_FILTER_STOP
		if button:
			button.disabled = value
			_update_button_mouse_filter()
		if item_control:
			item_control.locked = value

## Button.
@onready var button: Button


# Called when ready.
func _ready() -> void:
	_create_button()
	tooltip_text = get_description()


## Generates an explanation of the effect the item has.
@abstract func get_description() -> String


## Returns the stats with the item effect applied.
@abstract func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats


# Creates a button as the first child.
func _create_button() -> void:
	button = Button.new()
	button.disabled = locked
	_update_button_mouse_filter()
	button.size_flags_horizontal = SIZE_FILL
	button.size_flags_vertical = SIZE_FILL
	button.pressed.connect(_pressed)
	add_child(button)
	move_child(button, 0)


func _update_button_mouse_filter():
	button.mouse_filter = MOUSE_FILTER_PASS if clickable else MOUSE_FILTER_IGNORE


# Called when the button is pressed.
func _pressed() -> void:
	pressed.emit()
	apply_effect()


## Applies the item effect to the global stats.
func apply_effect() -> void:
	var new_stats = transform_stats(StatsController.stats)
	StatsController.change_stats(new_stats)
	effect_applied.emit()
