extends Node

### Signals

# Signals emitted by the player and its gun
signal player_health_updated
signal player_stats_updated
signal gun_stats_updated

# Signals emitted by other nodes
signal player_health_must_update
signal player_stats_must_update
signal gun_stats_must_update

### Variables

# Player health
var player_health: int
var player_max_health: int

# Player stats
var player_speed: float
var player_damage_effect_time: float

# Gun stats
var bullet_speed: float
var bullet_damage: int
var bullet_knockback_factor: float
var gun_shooting_cooldown: float

### Functions

## Player health

# Called by the player after its health changes
func update_player_health(new_health: int = player_health, new_max_health: int = player_max_health) -> void:
	player_health = new_health
	player_max_health = new_max_health
	player_health_updated.emit(player_health, player_max_health)

# Called by other nodes to affect player health
func change_player_health(new_health: int = player_health, new_max_health: int = player_max_health) -> void:
	player_health_must_update.emit(new_health, new_max_health)

# Called by other nodes to affect player health
func change_player_max_health(new_max_health: int = player_max_health) -> void:
	change_player_health(player_health, new_max_health)

# Heals the player by the given amount
func heal_player(amount: int) -> void:
	change_player_health(player_health + amount)

## Player stats

# Called by the player after its stats change
func update_player_stats(new_speed: float, new_damage_effect_time: float) -> void:
	player_speed = new_speed
	player_damage_effect_time = new_damage_effect_time
	player_stats_updated.emit(player_speed, player_damage_effect_time)

# Called by other nodes to affect player stats
func change_player_stats(new_speed: float, new_damage_effect_time: float) -> void:
	player_stats_must_update.emit(new_speed, new_damage_effect_time)

## Gun stats

# Called by the gun after its stats change
func update_gun_stats(new_bullet_speed: float, new_damage: int, new_knockback_factor: float, new_shooting_cooldown: float) -> void:
	bullet_speed = new_bullet_speed
	bullet_damage = new_damage
	bullet_knockback_factor = new_knockback_factor
	gun_shooting_cooldown = new_shooting_cooldown
	gun_stats_updated.emit(bullet_speed, bullet_damage, bullet_knockback_factor, gun_shooting_cooldown)

# Called by other nodes to affect gun stats
func change_gun_stats(new_bullet_speed: float, new_damage: int, new_knockback_factor: float, new_shooting_cooldown: float) -> void:
	gun_stats_must_update.emit(new_bullet_speed, new_damage, new_knockback_factor, new_shooting_cooldown)
