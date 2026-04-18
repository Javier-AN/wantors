extends Node

#region Signals
# Controled by the player and its gun
## Emitted when the health value is updated
signal player_health_updated
## Emitted when the player stats are updated
signal player_stats_updated
## Emitted when the gun stats are updated
signal gun_stats_updated

# Controled by other nodes
## Emitted when a node requires the player to change its health
signal player_health_must_update
## Emitted when a node requires the player to change its stats
signal player_stats_must_update
## Emitted when a node requires the gun to change its stats
signal gun_stats_must_update
#endregion

## Current player health.
var player_health: int
## Current stats.
var stats: StatsClass.Stats


# Called when ready
func _ready() -> void:
	stats = StatsClass.Stats.new(StatsClass.MobStats.new(0, 0, 0), StatsClass.GunStats.new(0, 0, 0, 0))


#region Update functions
# Called by by the player and its gun

## Updates the internal value and emits a signal.
func update_player_health(new_health: int) -> void:
	player_health = new_health
	player_health_updated.emit(new_health)


## Updates the internal values and emits a signal.
func update_player_stats(new_stats: StatsClass.MobStats) -> void:
	stats.player_stats = new_stats
	player_stats_updated.emit(new_stats)


## Updates the internal values and emits a signal.
func update_gun_stats(new_stats: StatsClass.GunStats) -> void:
	stats.gun_stats = new_stats
	gun_stats_updated.emit(new_stats)

#endregion


#region Change functions
# Called by other nodes

## Tells the player to change its health.
func change_player_health(new_health: int) -> void:
	player_health_must_update.emit(new_health)


## Tells the player to heal by the given amount.
func heal_player(amount: int) -> void:
	change_player_health(player_health + amount)


## Tells the player to heal completely.
func fully_heal_player() -> void:
	change_player_health(stats.player_stats.max_health)


## Tells the player to change its stats.
func change_stats(new_stats: StatsClass.Stats) -> void:
	change_player_stats(new_stats.player_stats)
	change_gun_stats(new_stats.gun_stats)


## Tells the player to change its stats.
func change_player_stats(new_stats: StatsClass.MobStats) -> void:
	player_stats_must_update.emit(new_stats)


## Tells the gun to change its stats.
func change_gun_stats(new_stats: StatsClass.GunStats) -> void:
	gun_stats_must_update.emit(new_stats)

#endregion
