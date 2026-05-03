extends Button


@onready var main_scene: PackedScene = load("res://scenes/game/main/main.tscn")


func _ready() -> void:
	pressed.connect(_play, ConnectFlags.CONNECT_ONE_SHOT)


func _play() -> void:
	get_tree().change_scene_to_packed(main_scene)
