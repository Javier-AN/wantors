extends Node

class Stats:
	var player_stats: MobStats
	var gun_stats: GunStats

	func _init(ps: MobStats, gs: GunStats):
		player_stats = ps
		gun_stats = gs

class MobStats:
	var speed: float
	var damage_effect_time: float
	var max_health: int

	func _init(s: float, det: float, mh: int):
		speed = s
		damage_effect_time = det
		max_health = mh

class GunStats:
	var bullet_speed: float
	var bullet_damage: int
	var bullet_knockback_factor: float
	var shooting_cooldown: float

	func _init(bs: float, bd: int, bkf: float, sc: float):
		bullet_speed = bs
		bullet_damage = bd
		bullet_knockback_factor = bkf
		shooting_cooldown = sc
