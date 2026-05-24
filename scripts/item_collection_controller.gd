extends Node

var item_pool: Array[PackedScene]
var unlocked_items: Array[int]

var _items_dir_path: String = "res://scenes/items"


# Called on instantiation
func _init() -> void:
	_load_items_in_dir(_items_dir_path)


# Loads all the items in a directory
func _load_items_in_dir(dir_path):
	# Open directory
	var dir = DirAccess.open(dir_path)
	# Recursively iterate subdirectories
	for subdir_name in dir.get_directories():
		_load_items_in_dir(dir_path + "/" + subdir_name)
	# Iterate files
	for file_name in dir.get_files():
		file_name = Utils.trim_remap(file_name)
		# If file is a scene, load it
		if file_name.get_extension() == "tscn":
			var item := load(dir_path + "/" + file_name)
			item_pool.append(item)
		file_name = dir.get_next()


## Unlocks the first locked item.
func unlock_next_item() -> int:
	var pool_size = item_pool.size()
	# Check if all items are unlocked
	if unlocked_items.size() >= pool_size:
		return -1
	# Select a random locked item
	var new_item: int = 0
	for i in range(item_pool.size()):
		if i not in unlocked_items:
			new_item = i
			break
	# Unlock it
	unlocked_items.append(new_item)
	return new_item


## Unlocks a random item.
func unlock_random_item() -> int:
	var pool_size = item_pool.size()
	# Check if all items are unlocked
	if unlocked_items.size() >= pool_size:
		return -1
	# Select a random locked item
	var new_item := randi_range(0, pool_size - 1)
	while new_item in unlocked_items:
		new_item = randi_range(0, pool_size - 1)
	# Unlock it
	unlocked_items.append(new_item)
	return new_item
