class_name Main
extends Node

# Nodes
@onready var timer: Timer = $Timer
@onready var spawner: Spawner = $Spawner
@onready var _ui_container: CanvasLayer = $UIContainer
@onready var _level_label: Label = $UIContainer/LevelContainer/LevelValue

# Scenes
@onready var item_selection_menu: PackedScene = load("res://scenes/ui/item_selection_menu/item_selection_menu.tscn")
@onready var transition_scene: PackedScene = load("res://scenes/ui/transition_message_screen/transition_message_screen.tscn")
@onready var item_unlock: PackedScene = load("res://scenes/ui/item_unlock_screen/item_unlock_screen.tscn")

# Private variables
var _level: int = 0
var _final_level: int = 3
var _horde_size: int
var _upgrade_chance: float


# Called when ready
func _ready() -> void:
	timer.timeout.connect(_spawn_horde)
	spawner.mob_cap_reached.connect(timer.stop)
	spawner.enemies_cleared.connect(_level_finished)
	_new_level()


# Called every tick
func _physics_process(_delta: float) -> void:
	# ONLY FOR TESTING PURPOSES
	if Input.is_action_just_pressed("ui_home"):
		_level_finished()


# Spawns a new horde of enemies
func _spawn_horde() -> void:
	spawner.spawn_enemies(_horde_size, _upgrade_chance)


# Starts a new level
func _new_level() -> void:
	_level_label.text = str(_level + 1)
	# Adapt difficulty to new level
	_horde_size = 5 + _level * 5
	_upgrade_chance = _level * 0.05
	if _upgrade_chance > 0.3:
		_upgrade_chance = 0.3
	# Start the spawner
	spawner.reset_mob_count(5 + _level * 10)
	timer.start()


# Called when the stage is cleared
func _level_finished() -> void:
	if _level < _final_level:
		_show_item_menu()
	else:
		_end_game()
		

# Shows item menu
func _show_item_menu() -> void:
	var menu: ItemSelectionMenu = item_selection_menu.instantiate()
	_ui_container.add_child(menu)
	_ui_container.move_child(menu, _ui_container.get_children().size() - 2)
	menu.item_chosen.connect(_level_up)


# Increases the level and starts a new one
func _level_up() -> void:
	# Upgrade difficulty
	_level += 1
	# Heal the player
	StatsController.fully_heal_player()
	# Starts the new level
	_new_level()


# Called when the game ends
func _end_game():
	var transition := transition_scene.instantiate()
	transition.message = tr(&"GAME_END")
	transition.target = item_unlock
	add_sibling(transition)
	queue_free()


## Randomizes all the stats.
## @experimental Temporally avaliable, only for testing purpuses.
func randomize_stats() -> void:
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
