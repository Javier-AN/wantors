class_name ItemSelectionMenu
extends Control

signal item_chosen

@export var number_of_items: int = 2

@onready var item_container: Container = $VBoxContainer/ItemContainer

var picked_items: Array[Item]


# Called when ready
func _ready() -> void:
	PauseController.toggle(true)
	_pick_items()


# Picks random items from the pool, instantiates them and adds them to the buttons
func _pick_items() -> void:
	var picks := Utils.pick_randoms(ItemCollectionController.unlocked_items, number_of_items)
	for pick in picks:
		var item: Item = ItemCollectionController.item_pool[pick].instantiate()
		item_container.add_child(item)
		item.effect_applied.connect(_self_destroy)


func _self_destroy() -> void:
	PauseController.toggle(false)
	item_chosen.emit()
	queue_free()
