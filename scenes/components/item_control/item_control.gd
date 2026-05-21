class_name ItemControl
extends Control
## A choosable item that modifies player stats.

## Icon that represents the item.
@export var image: Texture2D
## Name of the item.
@export var title: String
## Short catch phrase.
@export var subtitle: String
## Indicates if the item is locked.
@export var locked: bool:
	set(value):
		locked = value
		if _panel_container:
			_update_panel()

@onready var _texture_rect: TextureRect = $GlobalContainer/PanelContainer/MarginContainer/TextureRect
@onready var _title_label: Label = $GlobalContainer/TextContainer/TitleLabel
@onready var _subtitle_label: Label = $GlobalContainer/TextContainer/SubtitleLabel
@onready var _panel_container: PanelContainer = $GlobalContainer/PanelContainer


func _ready() -> void:
	_texture_rect.texture = image
	_title_label.text = title
	_subtitle_label.text = subtitle
	_update_panel()


func _update_panel() -> void:
	_panel_container.theme_type_variation = &"LockedItemPanel" if locked else &"ItemPanel"
