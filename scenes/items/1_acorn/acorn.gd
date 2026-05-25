class_name Acorn
extends Item


const DAMAGE_FACTOR_FACTOR: float = 0.8


func get_description() -> String:
	var protection: float = (1.0 - DAMAGE_FACTOR_FACTOR) * 100.0
	return "%s: +%.f%%" % [tr(&"STATS_PROTECTION"), protection]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.player_stats.damage_factor *= DAMAGE_FACTOR_FACTOR
	return stats
