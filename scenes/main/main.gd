class_name Main
extends Node


# Nodes
@export var timer: Timer 
@export var spawner: Spawner
@export var item_menu: PackedScene

@onready var canvas: CanvasLayer = $CanvasLayer

# Private variables
var _level: int = 0
var _horde_size: int
var _upgrade_chance: float


# Called when ready
func _ready() -> void:
	timer.timeout.connect(_spawn_horde)
	spawner.mob_cap_reached.connect(timer.stop)
	spawner.enemies_cleared.connect(_show_item_menu)
	_new_level()


# Called every tick
func _physics_process(_delta: float) -> void:
	# Test stats controller
	if Input.is_action_just_pressed("ui_accept"):
		_show_item_menu()


# Spawns a new horde of enemies
func _spawn_horde() -> void:
	spawner.spawn_enemies(_horde_size, _upgrade_chance)


# Starts a new level
func _new_level() -> void:
	# Adapt difficulty to new level
	_horde_size = 5 + _level * 5
	_upgrade_chance = _level * 0.05
	if _upgrade_chance > 0.3:
		_upgrade_chance = 0.3
	# Start the spawner
	spawner.reset_mob_count(5 + _level * 10)
	timer.start()


# Shows item menu
func _show_item_menu() -> void:
	var menu: ItemMenu = item_menu.instantiate()
	canvas.add_child(menu)
	menu.item_chosen.connect(_level_up)


# Increases the level and starts a new one
func _level_up() -> void:
	# Upgrade difficulty
	_level += 1
	# Heal the player
	StatsController.fully_heal_player()
	# Starts the new level
	_new_level()


# Randomizes all the stats
func _randomize_stats() -> void:
	var s := Utils.round_to_dec(randf_range(30.0, 200.0), 2)
	var det := Utils.round_to_dec(randf_range(0.1, 4.0), 2)
	var mh := randi_range(400, 1000)
	var bs := Utils.round_to_dec(randf_range(30.0, 200.0), 2)
	var bd := randi_range(1, 50)
	var bkf := Utils.round_to_dec(randf_range(0.1, 5.0), 2)
	var sc := Utils.round_to_dec(randf_range(0.01, 1.0), 2)
	var stats := StatsClass.Stats.new(StatsClass.MobStats.new(s, det, mh),
			StatsClass.GunStats.new(bs, bd, bkf, sc))
	StatsController.change_stats(stats)
