class_name StatsUI
extends Control


## Text label collection.
@export var text_labels: Array[Label]
## Value label for player health.
@export var player_health_label: Label
## Value label for player speed.
@export var player_speed_label: Label
## Value label for player damage effect time.
@export var player_det_label: Label
## Value label for bullet speed.
@export var bullet_speed_label: Label
## Value label for bullet damage.
@export var bullet_damage_label: Label
## Value label for bullet knockback factor.
@export var bullet_knockback_factor_label: Label
## Value label for gun fire rate.
@export var gun_fire_rate_label: Label


# Called when ready
func _ready() -> void:
	_prepare_text_labels()
	# Set current values
	_update_player_health(StatsController.player_health)
	_update_player_stats(StatsController.stats.player_stats)
	_update_gun_stats(StatsController.stats.gun_stats)
	# Set update triggers
	StatsController.player_health_updated.connect(_update_player_health)
	StatsController.player_stats_updated.connect(_update_player_stats)
	StatsController.gun_stats_updated.connect(_update_gun_stats)


# Capitalizes labels text and adds a separator
func _prepare_text_labels() -> void:
	for tl in text_labels:
		tl.text = Utils.first_to_upper(tr(tl.text)) + ": "


# Updates value label for player health
func _update_player_health(health: int) -> void:
	var max_health := StatsController.stats.player_stats.max_health
	player_health_label.text = "%d/%d" % [health, max_health]


# Updates value labels for player stats
func _update_player_stats(stats: StatsClass.MobStats) -> void:
	player_speed_label.text = str(stats.speed)
	player_det_label.text = str(stats.damage_effect_time)


# Updates value labels for gun stats
func _update_gun_stats(stats: StatsClass.GunStats) -> void:
	bullet_speed_label.text = str(stats.bullet_speed)
	bullet_damage_label.text = str(stats.bullet_damage)
	bullet_knockback_factor_label.text = str(stats.bullet_knockback_factor)
	gun_fire_rate_label.text = str(10 / stats.shooting_cooldown)
