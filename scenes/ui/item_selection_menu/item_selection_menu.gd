class_name ItemSelectionMenu
extends Control

signal item_chosen

@export var number_of_items: int = 2

var picked_items: Array[Item]
var _first_item: Item

@onready var item_container: Container = $VBoxContainer/ItemContainer



# Called when ready
func _ready() -> void:
	PauseController.toggle(true)
	_pick_items()
	PauseController.pause_menu_closed.connect(_focus_first_item)


# Picks random items from the pool, instantiates them and adds them to the buttons
func _pick_items() -> void:
	var picks := Utils.pick_randoms(ItemCollectionController.unlocked_items, number_of_items)
	var item: Item
	var first := true
	for pick in picks:
		item = ItemCollectionController.item_pool[pick].instantiate()
		item_container.add_child(item)
		item.effect_applied.connect(_self_destroy)
		if first:
			_first_item = item
			_focus_first_item()
			first = false


func _focus_first_item() -> void:
	_first_item.button.grab_focus.call_deferred()


func _self_destroy() -> void:
	PauseController.toggle(false)
	item_chosen.emit()
	queue_free()
