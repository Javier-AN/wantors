class_name Acorn
extends Item


const BULLET_KNOCKBACK_FACTOR_FACTOR: float = 1.2


func get_description() -> String: 
	return "%s: x%f" % [tr(&"BULLET_KNOCKBACK_FACTOR"), BULLET_KNOCKBACK_FACTOR_FACTOR]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.gun_stats.bullet_knockback_factor *= BULLET_KNOCKBACK_FACTOR_FACTOR
	return stats
