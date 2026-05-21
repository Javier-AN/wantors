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
