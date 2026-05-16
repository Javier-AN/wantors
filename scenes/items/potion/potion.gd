class_name Potion
extends Item


const SPEED_PLUS: float = 10.0


func get_description() -> String: 
	return "%s: +%f" % [tr(&"SPEED"), SPEED_PLUS]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.player_stats.speed += SPEED_PLUS
	return stats
