extends SoundPlayer


func _on_node_added(node: Node) -> void:
	if node is Control:
		node.focus_entered.connect(_play_hover)
	if node is Button:
		node.mouse_entered.connect(_play_hover)
		node.pressed.connect(_play_pressed)


func _play_hover() -> void:
	play(preload("res://assets/sfx/cursor.ogg"))


func _play_pressed() -> void:
	play(preload("res://assets/sfx/select.ogg"))
