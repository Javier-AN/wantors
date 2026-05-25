class_name TransitionMessage
extends Control

@onready var _label: Label = $GlobalContainer/Label
@onready var _ok_button: Button = $GlobalContainer/OkButton

var message: String
var target: PackedScene


# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_label.text = message
	_ok_button.pressed.connect(_go_to_target)
	_ok_button.grab_focus.call_deferred()


# Changes the scene to the target
func _go_to_target():
	var scene := target.instantiate()
	add_sibling(scene)
	queue_free()
