extends Node

# Nodes
@export var timer: Timer 
@export var spawner: Spawner

# Private variables
var _level: int = 1
var _horde_size: int = 15
var _upgrade_chance: float = 0.0

# Called when ready
func _ready() -> void:
	_new_level()
	timer.timeout.connect(_spawn_horde)
	# TODO: spawner.mob_cap_reached.connect(_stop_timer)
	spawner.enemies_cleared.connect(_level_up)

# Called every tick
func _physics_process(_delta: float) -> void:
	# Test stats controller
	if Input.is_action_just_pressed("ui_accept"):
		_randomize_stats()

# Spawns a new horde of enemies
func _spawn_horde():
	spawner.spawn_enemies(_horde_size, _upgrade_chance)

# Starts a new level
func _new_level():
	_horde_size = 15 + _level * 5
	_upgrade_chance = _level * 0.05
	if _upgrade_chance > 0.3:
		_upgrade_chance = 0.3
	# TODO: show item menu to boost stats
	# TODO: restart Timer
	spawner.reset_mob_count(0 + _level * 10)

# Increases the level and starts a new one
func _level_up():
	_level += 1
	StatsController.heal_player(10)
	_new_level()

# Randomizes all the stats
func _randomize_stats():
	var s := Utils.round_to_dec(randf_range(30.0, 200.0), 2)
	var det := Utils.round_to_dec(randf_range(0.1, 4.0), 2)
	var mh := randi_range(400, 1000)
	var bs := Utils.round_to_dec(randf_range(30.0, 200.0), 2)
	var bd := randi_range(1, 50)
	var bkf := Utils.round_to_dec(randf_range(0.1, 5.0), 2)
	var sc := Utils.round_to_dec(randf_range(0.01, 1.0), 2)
	var stats := StatsClass.Stats.new(StatsClass.MobStats.new(s, det, mh), StatsClass.GunStats.new(bs, bd, bkf, sc))
	StatsController.change_stats(stats)
