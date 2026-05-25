class_name ItemControl
extends Control
## A choosable item that modifies player stats.

## Icon that represents the item.
@export var image: Texture2D
## Name of the item.
@export var title: String
## Short catch phrase.
@export var subtitle: String
## Explains what the item does.
@export var description: String:
	set(value):
		description = value
		if is_node_ready():
			_update()
## Indicates if the item is locked.
@export var locked: bool:
	set(value):
		locked = value
		if is_node_ready():
			_update()

@onready var _texture_rect: TextureRect = $GlobalContainer/PanelContainer/MarginContainer/TextureRect
@onready var _title_label: Label = $GlobalContainer/TextContainer/TitleLabel
@onready var _subtitle_label: Label = $GlobalContainer/TextContainer/SubtitleLabel
@onready var _description_label: Label = $GlobalContainer/TextContainer/DescriptionLabel
@onready var _panel_container: PanelContainer = $GlobalContainer/PanelContainer


func _ready() -> void:
	_texture_rect.texture = image
	_title_label.text = title
	_update()


func _update() -> void:
	if locked:
		_subtitle_label.text = tr(&"ITEM_LOCKED")
		_description_label.text = ""
		_panel_container.theme_type_variation = &"LockedItemPanel"
	else:
		_subtitle_label.text = subtitle
		_description_label.text = description
		_panel_container.theme_type_variation = &"ItemPanel"
