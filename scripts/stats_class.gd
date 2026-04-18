class_name StatsClass
extends Node


## Stat values collection.
class Stats:
	
	## Player stats.
	var player_stats: MobStats
	## Gun stats.
	var gun_stats: GunStats

	func _init(ps: MobStats, gs: GunStats):
		player_stats = ps
		gun_stats = gs


## Mob stat values collection.
class MobStats:
	
	## Mob speed.
	var speed: float
	## Mob damage effect time.
	var damage_effect_time: float
	## Mob health.
	var max_health: int

	func _init(s: float, det: float, mh: int):
		speed = s
		damage_effect_time = det
		max_health = mh


## Gun stat values collection.
class GunStats:
	
	## Bullet speed.
	var bullet_speed: float
	## Bullet damage.
	var bullet_damage: int
	## Bullet knockback factor.
	var bullet_knockback_factor: float
	## Gun shooting cooldown.
	var shooting_cooldown: float

	func _init(bs: float, bd: int, bkf: float, sc: float):
		bullet_speed = bs
		bullet_damage = bd
		bullet_knockback_factor = bkf
		shooting_cooldown = sc
