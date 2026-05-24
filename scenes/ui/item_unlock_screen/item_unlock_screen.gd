class_name ItemUnlock
extends Control

@export var main_menu: PackedScene

@onready var _label: Label = $GlobalContainer/Label
@onready var _item_container: Control = $GlobalContainer/ItemContainer
@onready var _ok_button: Button = $GlobalContainer/OkButton
@onready var _separator: HSeparator = $GlobalContainer/HSeparatorBottom


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = _unlock_new_item()
	if index >= 0:
		_label.text = tr(&"ITEM_UNLOCKED")
		_show_item(index)
	else:
		_label.text = tr(&"ITEM_ALL_UNLOCKED")
		_separator.visible = false
	_ok_button.pressed.connect(_return_to_main_menu)
	_ok_button.grab_focus.call_deferred()


func _unlock_new_item() -> int:
	var unlocked := ItemCollectionController.unlock_next_item()
	SaveController.save_game_data()
	return unlocked


func _show_item(index: int) -> void:
	var item: Item = ItemCollectionController.item_pool[index].instantiate()
	item.clickable = false
	item.locked = false
	_item_container.add_child(item)
	_item_container.visible = true


# Changes the scene to the main menu
func _return_to_main_menu():
	var menu := main_menu.instantiate()
	add_sibling(menu)
	queue_free()
