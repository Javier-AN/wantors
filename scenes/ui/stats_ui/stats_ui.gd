class_name StatsUI
extends Control

# Nodes
@export var player_health_label: Label
@export var player_speed_label: Label
@export var player_det_label: Label
@export var bullet_speed_label: Label
@export var bullet_damage_label: Label
@export var bullet_knockback_factor_label: Label
@export var gun_shooting_cooldown_label: Label

# Called when ready
func _ready() -> void:
	_update_player_health(StatsController.player_health)
	_update_player_stats(StatsController.stats.player_stats)
	_update_gun_stats(StatsController.stats.gun_stats)
	StatsController.player_health_updated.connect(_update_player_health)
	StatsController.player_stats_updated.connect(_update_player_stats)
	StatsController.gun_stats_updated.connect(_update_gun_stats)

func _update_player_health(health: int) -> void:
	player_health_label.text = str(health) + "/" + str(StatsController.stats.player_stats.max_health)

func _update_player_stats(stats: StatsClass.MobStats) -> void:
	player_speed_label.text = str(stats.speed)
	player_det_label.text = str(stats.damage_effect_time)

func _update_gun_stats(stats: StatsClass.GunStats) -> void:
	bullet_speed_label.text = str(stats.bullet_speed)
	bullet_damage_label.text = str(stats.bullet_damage)
	bullet_knockback_factor_label.text = str(stats.bullet_knockback_factor)
	gun_shooting_cooldown_label.text = str(stats.shooting_cooldown)
