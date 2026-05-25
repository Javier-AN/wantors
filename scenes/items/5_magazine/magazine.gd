class_name Magazine
extends Item


const FIRE_RATE_FACTOR: float = 1.25


func get_description() -> String:
	var fire_rate: float = (FIRE_RATE_FACTOR - 1.0) * 100.0
	return "%s: +%.f%%" % [tr(&"STATS_FIRE_RATE"), fire_rate]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.gun_stats.shooting_cooldown /= FIRE_RATE_FACTOR
	return stats
