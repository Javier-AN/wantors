@abstract
class_name Item
extends Button
## A choosable item that modifies player stats.

signal effect_applied

## Name of the item.
@export var title: String
## Short catch phrase.
@export var subtitle: String


func _ready() -> void:
	_fill_text()
	pressed.connect(apply_effect)


func _fill_text():
	text = "%s\n%s" % [tr(title), tr(subtitle)]


## Generates an explanation of the effect the item has.
@abstract func get_description() -> String


## Applies the item effect to the stats.
@abstract func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats


func apply_effect() -> void:
	var new_stats = transform_stats(StatsController.stats)
	StatsController.change_stats(new_stats)
	effect_applied.emit()
