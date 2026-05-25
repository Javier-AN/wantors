class_name StatsUI
extends Control

## Value label for player speed.
@onready var player_speed_label: Label = $PlayerSpeed/PlayerSpeedValue
## Value label for player damage effect time.
@onready var player_protection_label: Label = $PlayerProtection/PlayerProtectionValue
## Value label for bullet speed.
@onready var bullet_speed_label: Label = $BulletSpeed/BulletSpeedValue
## Value label for bullet damage.
@onready var bullet_damage_label: Label = $BulletDamage/BulletDamageValue
## Value label for gun fire rate.
@onready var gun_fire_rate_label: Label = $GunFireRate/GunFireRateValue


# Called when ready
func _ready() -> void:
	visible = PreferencesController.preferences.extended_ui
	# Set current values
	_update_player_stats(StatsController.stats.player_stats)
	_update_gun_stats(StatsController.stats.gun_stats)
	# Set update triggers
	StatsController.player_stats_updated.connect(_update_player_stats)
	StatsController.gun_stats_updated.connect(_update_gun_stats)


# Updates value labels for player stats
func _update_player_stats(stats: StatsClass.MobStats) -> void:
	player_speed_label.text = str(stats.speed)
	player_protection_label.text = str(int(200.0 - stats.damage_factor * 100.0))


# Updates value labels for gun stats
func _update_gun_stats(stats: StatsClass.GunStats) -> void:
	bullet_speed_label.text = str(stats.bullet_speed)
	bullet_damage_label.text = str(stats.bullet_damage)
	gun_fire_rate_label.text = str(snapped(10 / stats.shooting_cooldown, 0.1))
