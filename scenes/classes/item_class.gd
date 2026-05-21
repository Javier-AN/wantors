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
		if _button:
			_button.mouse_filter = MOUSE_FILTER_STOP if clickable else MOUSE_FILTER_IGNORE
## Indicates if the item is locked.
@export var locked: bool = false:
	set(value):
		locked = value
		if _button:
			_button.disabled = value
		if item_control:
			item_control.locked = value

# Button.
@onready var _button: Button


# Called when ready.
func _ready() -> void:
	_create_button()


## Generates an explanation of the effect the item has.
@abstract func get_description() -> String


## Returns the stats with the item effect applied.
@abstract func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats


# Creates a button as the first child.
func _create_button() -> void:
	_button = Button.new()
	_button.disabled = locked
	_button.mouse_filter = MOUSE_FILTER_STOP if clickable else MOUSE_FILTER_IGNORE
	_button.size_flags_horizontal = SIZE_FILL
	_button.size_flags_vertical = SIZE_FILL
	_button.pressed.connect(_pressed)
	add_child(_button)
	move_child(_button, 0)


# Called when the button is pressed.
func _pressed() -> void:
	pressed.emit()
	apply_effect()


## Applies the item effect to the global stats.
func apply_effect() -> void:
	var new_stats = transform_stats(StatsController.stats)
	StatsController.change_stats(new_stats)
	effect_applied.emit()
