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

var player_health: int
var stats: StatsClass.Stats

### Functions

func _ready() -> void:
	stats = StatsClass.Stats.new(StatsClass.MobStats.new(0, 0, 0), StatsClass.GunStats.new(0, 0, 0, 0))

## Update functions: Called by player and gun after updating their values

# Updates the internal value and emits a signal
func update_player_health(new_health: int) -> void:
	player_health = new_health
	player_health_updated.emit(new_health)

# Updates the internal values and emits a signal
func update_player_stats(new_stats: StatsClass.MobStats) -> void:
	stats.player_stats = new_stats
	player_stats_updated.emit(new_stats)

# Updates the internal values and emits a signal
func update_gun_stats(new_stats: StatsClass.GunStats) -> void:
	stats.gun_stats = new_stats
	gun_stats_updated.emit(new_stats)

## Change functions: Called by other nodes to change the values

# Tells the player to change its health
func change_player_health(new_health: int) -> void:
	player_health_must_update.emit(new_health)

# Tells the player to heal the given amount
func heal_player(amount: int) -> void:
	change_player_health(player_health + amount)

# Tells the player to change its stats
func change_stats(new_stats: StatsClass.Stats) -> void:
	change_player_stats(new_stats.player_stats)
	change_gun_stats(new_stats.gun_stats)

# Tells the player to change its stats
func change_player_stats(new_stats: StatsClass.MobStats) -> void:
	player_stats_must_update.emit(new_stats)

# Tells the gun to change its stats
func change_gun_stats(new_stats: StatsClass.GunStats) -> void:
	gun_stats_must_update.emit(new_stats)
