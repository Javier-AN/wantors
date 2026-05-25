class_name PlayerHealthBar
extends ProgressBar

@onready var _label: Label = $PlayerHealthLabel


# Called when ready
func _ready() -> void:
	_set_visibility(PreferencesController.preferences.extended_ui)
	PreferencesController.stats_visibility_changed.connect(_set_visibility)
	_update_player_health(StatsController.player_health)
	StatsController.player_health_updated.connect(_update_player_health)


# Sets the visibility of the label
func _set_visibility(new_state: bool) -> void:
	_label.visible = new_state


# Updates value label for player health
func _update_player_health(health: int) -> void:
	var max_health := StatsController.stats.player_stats.max_health
	_label.text = "%d/%d" % [health, max_health]
	custom_minimum_size = Vector2(max_health * 8, custom_minimum_size.y)
	max_value = max_health
	value = health
