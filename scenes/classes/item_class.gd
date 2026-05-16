@abstract
class_name Item
extends Control
## A choosable item that modifies player stats.

signal effect_applied
signal pressed

var disabled: bool:
	set(value):
		disabled = value
		if button:
			button.disabled = value

@onready var button = Button.new()


func _ready() -> void:
	button.disabled = disabled
	button.size_flags_horizontal = SIZE_FILL
	button.size_flags_vertical = SIZE_FILL
	add_child(button)
	move_child(button, 0)
	button.pressed.connect(_pressed)


## Generates an explanation of the effect the item has.
@abstract func get_description() -> String


## Returns the stats with the item effect applied.
@abstract func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats


func _pressed() -> void:
	pressed.emit()
	apply_effect()


## Applies the item effect to the global stats.
func apply_effect() -> void:
	var new_stats = transform_stats(StatsController.stats)
	StatsController.change_stats(new_stats)
	effect_applied.emit()
