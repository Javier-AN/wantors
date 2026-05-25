class_name TransitionMessage
extends Control

@onready var _timer: Timer = $Timer
@onready var _label: Label = $GlobalContainer/Label
@onready var _ok_button: Button = $GlobalContainer/OkButton

var message: String
var target: PackedScene
var typing_interval: float = 0.06
var _translated_text: String
var _current_char: int = 0


# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_translated_text = tr(message)
	_timer.timeout.connect(_type)
	_timer.start(typing_interval * 20)


# Types the next letter
func _type() -> void:
	if _current_char < _translated_text.length():
		var new_char := _translated_text[_current_char]
		var next_interval := typing_interval
		if new_char == " ":
			next_interval *= 2
		elif new_char == ",":
			next_interval *= 4
		elif new_char == ".":
			next_interval *= 10
		else:
			UiSoundPlayer._play_type()
		_label.text += new_char
		_timer.start(next_interval)
		_current_char += 1
	else:
		_show_button()


# Shows the ok button
func _show_button() -> void:
	_ok_button.visible = true
	_ok_button.pressed.connect(_go_to_target)
	_ok_button.grab_focus.call_deferred()


# Changes the scene to the target
func _go_to_target():
	var scene := target.instantiate()
	add_sibling(scene)
	queue_free()
