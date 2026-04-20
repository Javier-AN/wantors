class_name ItemMenu
extends Control

signal item_chosen

@export var number_of_items: int = 2
@export var item_pool: Array[PackedScene]

@onready var item_container: Container = $ItemContainer

var picked_items: Array[Item]


# Called when ready
func _ready() -> void:
	_pick_items()


# Picks random items from the pool, instantiates them and adds them to the buttons
func _pick_items() -> void:
	var picks := Utils.pick_randoms(item_pool, number_of_items)
	for pick in picks:
		var item: Item = pick.instantiate()
		item_container.add_child(item)
		item.effect_applied.connect(_self_destroy)


func _self_destroy() -> void:
	item_chosen.emit()
	queue_free()
