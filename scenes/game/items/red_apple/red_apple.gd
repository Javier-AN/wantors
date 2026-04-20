class_name RedApple
extends Item


const MAX_HEALTH_PLUS: int = 20


func get_description() -> String: 
	return "%s: +%d" % [tr(&"HEALTH"), MAX_HEALTH_PLUS]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.player_stats.max_health += MAX_HEALTH_PLUS
	return stats
