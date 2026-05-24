class_name BigBullet
extends Item


const BULLET_DAMAGE_PLUS: int = 5


func get_description() -> String: 
	return "%s: +%d" % [tr(&"STATS_DAMAGE"), BULLET_DAMAGE_PLUS]


func transform_stats(stats: StatsClass.Stats) -> StatsClass.Stats:
	stats.gun_stats.bullet_damage += BULLET_DAMAGE_PLUS
	return stats
