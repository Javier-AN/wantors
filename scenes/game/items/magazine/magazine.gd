class_name Magazine
extends Item


const FIRE_RATE_FACTOR: float = 1.2


func get_description() -> String: 
	return "%s: x%d" % [tr(&"FIRE_RATE"), FIRE_RATE_FACTOR]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.gun_stats.shooting_cooldown /= FIRE_RATE_FACTOR
	return stats
