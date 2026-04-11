extends Node2D

# Nodes
@export var timer: Timer 
@export var spawner: Spawner

# Private variables
var _level: int = 1
var _horde_size: int = 15
var _upgrade_chance: float = 0.0

# Called when ready
func _ready() -> void:
	timer.timeout.connect(_spawn_horde)
	# TODO: spawner.mob_cap_reached.connect(_stop_timer)
	spawner.enemies_cleared.connect(_level_up)

# Spawns a new horde of enemies
func _spawn_horde():
	spawner.spawn_enemies(_horde_size, _upgrade_chance)

func _level_up():
	_level += 1
	_horde_size += 5
	if _upgrade_chance < 0.5:
		_upgrade_chance += 0.05
	StatsController.heal(10)
	# TODO: show item menu to boost stats
	spawner.reset_mob_count(50 + _level * 10)
