class_name PlayerHealthBar
extends ProgressBar

@onready var _label: Label = $PlayerHealthLabel


# Called when ready
func _ready() -> void:
	_update_player_health(StatsController.player_health)
	StatsController.player_health_updated.connect(_update_player_health)


# Updates value label for player health
func _update_player_health(health: int) -> void:
	var max_health := StatsController.stats.player_stats.max_health
	_label.text = "%d/%d" % [health, max_health]
	custom_minimum_size = Vector2(max_health * 2, custom_minimum_size.y)
	max_value = max_health
	value = health
