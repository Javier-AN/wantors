class_name TransitionMessage
extends Control

@onready var _label: Label = $Label

var message: String
var target: PackedScene


# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_label.text = message


# Called every frame
func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		_go_to_target()


# Changes the scene to the target
func _go_to_target():
	var scene := target.instantiate()
	add_sibling(scene)
	queue_free()
