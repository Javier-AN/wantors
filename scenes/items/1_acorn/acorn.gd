class_name Acorn
extends Item


const HIT_TIME_PLUS: float = 0.4


func get_description() -> String: 
	return "%s: +%.1f" % [tr(&"STATS_HIT_TIME"), HIT_TIME_PLUS]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.player_stats.hit_time += HIT_TIME_PLUS
	return stats
