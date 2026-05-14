extends Button


@onready var transition_scene: PackedScene = load("res://scenes/ui/transition_message/transition_message.tscn")
@onready var main_scene: PackedScene = load("res://scenes/game/main/main.tscn")


func _ready() -> void:
	pressed.connect(_play, CONNECT_ONE_SHOT)


func _play() -> void:
	var transition := transition_scene.instantiate()
	transition.message = &"GAME_START"
	transition.target = main_scene
	get_parent().get_parent().add_sibling(transition)
	get_parent().get_parent().queue_free()
