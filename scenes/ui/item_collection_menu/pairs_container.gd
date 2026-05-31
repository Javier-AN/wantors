extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_display_items()


func _display_items() -> void:
	var item_pool = ItemCollectionController.item_pool
	var unlocked_items = ItemCollectionController.unlocked_items
	for i in range(item_pool.size()):
		var item: Item = item_pool[i].instantiate()
		item.clickable = false
		item.locked = not i in unlocked_items
		add_child(item)


# CHEATS. ONLY FOR TESTING PURPOSES.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_page_down"):
		ItemCollectionController.unlock_next_item()
		_save_and_refresh()
	elif event.is_action_pressed("ui_page_up"):
		ItemCollectionController.reset_unlocks()
		_save_and_refresh()


func _save_and_refresh() -> void:
	SaveController.save_game_data()
	for child in get_children():
		child.queue_free()
	_display_items()
