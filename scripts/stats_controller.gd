extends Node

signal stats_changed
signal healed

# Stats
var max_health: int
var speed: float
var damage_effect_time: float
var bullet_speed: float
var shooting_cooldown: float

func update_stats() -> void:
	stats_changed.emit()

func heal(amount: int) -> void:
	healed.emit(amount)
