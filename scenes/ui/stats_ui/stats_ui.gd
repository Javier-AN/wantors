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
	_update_player_health(StatsController.player_health, StatsController.player_max_health)
	_update_player_stats(StatsController.player_speed, StatsController.player_damage_effect_time)
	_update_gun_stats(StatsController.bullet_speed, StatsController.bullet_damage, StatsController.bullet_knockback_factor, StatsController.gun_shooting_cooldown)
	StatsController.player_health_updated.connect(_update_player_health)
	StatsController.player_stats_updated.connect(_update_player_stats)
	StatsController.gun_stats_updated.connect(_update_gun_stats)

func _update_player_health(health: int, max_health: int) -> void:
	player_health_label.text = str(health) + "/" + str(max_health)

func _update_player_stats(speed: float, det: float) -> void:
	player_speed_label.text = str(speed)
	player_det_label.text = str(det)

func _update_gun_stats(bullet_speed: float, damage: int, knockback_factor: float, shooting_cooldown: float) -> void:
	bullet_speed_label.text = str(bullet_speed)
	bullet_damage_label.text = str(damage)
	bullet_knockback_factor_label.text = str(knockback_factor)
	gun_shooting_cooldown_label.text = str(shooting_cooldown)
