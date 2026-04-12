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

func _physics_process(_delta: float) -> void:
	# Test stats controller
	if Input.is_action_just_pressed("ui_accept"):
		var max_health := randi_range(400, 1000)
		var speed := randf_range(30.0, 200.0)
		speed = Utils.round_to_dec(speed, 2)
		var det := randf_range(0.1, 4.0)
		det = Utils.round_to_dec(det, 2)
		var b_speed := randf_range(30.0, 200.0)
		b_speed = Utils.round_to_dec(b_speed, 2)
		var damage := randi_range(1, 50)
		var kf := randf_range(0.1, 5.0)
		kf = Utils.round_to_dec(kf, 2)
		var cooldown := randf_range(0.01, 1.0)
		cooldown = Utils.round_to_dec(cooldown, 2)
		StatsController.change_player_max_health(max_health)
		StatsController.change_player_stats(speed, det)
		StatsController.change_gun_stats(b_speed, damage, kf, cooldown)

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
