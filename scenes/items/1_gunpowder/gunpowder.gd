class_name Gunpowder
extends Item


const BULLET_SPEED_PLUS: float = 60.0


func get_description() -> String: 
	return "%s: +%.f" % [tr(&"STATS_BULLET_SPEED"), BULLET_SPEED_PLUS]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.gun_stats.bullet_speed += BULLET_SPEED_PLUS
	return stats
