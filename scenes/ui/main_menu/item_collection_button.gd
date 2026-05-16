extends Button


@onready var collection_scene: PackedScene = load("res://scenes/ui/item_collection_menu/item_collection_menu.tscn")


func _ready() -> void:
	pressed.connect(_go_to_collection, CONNECT_ONE_SHOT)


func _go_to_collection() -> void:
	var collection := collection_scene.instantiate()
	get_parent().get_parent().add_sibling(collection)
	get_parent().get_parent().queue_free()
