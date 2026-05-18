class_name ItemControl
extends Control
## A choosable item that modifies player stats.

## Icon that represents the item.
@export var image: Texture2D
## Name of the item.
@export var title: String
## Short catch phrase.
@export var subtitle: String

@onready var _texture_rect: TextureRect = $GlobalContainer/TextureRect
@onready var _title_label: Label = $GlobalContainer/TextContainer/TitleLabel
@onready var _subtitle_label: Label = $GlobalContainer/TextContainer/SubtitleLabel


func _ready() -> void:
	_texture_rect.texture = image
	_title_label.text = title
	_subtitle_label.text = subtitle
