class_name LanguageSelection
extends HBoxContainer

@onready var _label: Label = $LanguageLabel
@onready var _prev_button: Button = $PreviousLanguageButton
@onready var _next_button: Button = $NextLanguageButton

var _selected_lang: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_selected_lang = PreferencesController.preferences.language
	if _selected_lang == -1:
		_selected_lang = 0
	_label.text = Constants.LANG_NAMES[_selected_lang]
	_prev_button.pressed.connect(_prev_pressed)
	_next_button.pressed.connect(_next_pressed)


func _update_lang() -> void:
	_label.text = Constants.LANG_NAMES[_selected_lang]
	PreferencesController.set_language(_selected_lang)


func _prev_pressed() -> void:
	if _selected_lang <= 0:
		_selected_lang = Constants.LANGS.size()
	_selected_lang -= 1
	_update_lang()


func _next_pressed() -> void:
	_selected_lang += 1
	if _selected_lang >= Constants.LANGS.size():
		_selected_lang = 0
	_update_lang()
