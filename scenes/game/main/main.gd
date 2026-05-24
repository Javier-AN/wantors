class_name Main
extends Node

#region Variables
var _level: int = 0
var _horde_size: int
var _upgrade_chance: float

@onready var _final_level: int = 2 + ItemCollectionController.unlocked_items.size()

@onready var player: Player = $Player
@onready var timer: Timer = $Timer
@onready var spawner: Spawner = $Spawner
@onready var _ui_container: CanvasLayer = $UIContainer
@onready var _level_label: Label = $UIContainer/LevelContainer/LevelValue
@onready var _bullet_container_player: Node2D = $BulletContainer/Player
@onready var _bullet_container_enemy: Node2D = $BulletContainer/Enemy

@onready var main_menu: PackedScene = load("res://scenes/ui/main_menu/main_menu.tscn")
@onready var item_selection_menu: PackedScene = load("res://scenes/ui/item_selection_menu/item_selection_menu.tscn")
@onready var transition_scene: PackedScene = load("res://scenes/ui/transition_message_screen/transition_message_screen.tscn")
@onready var item_unlock: PackedScene = load("res://scenes/ui/item_unlock_screen/item_unlock_screen.tscn")
#endregion


# Called when ready
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	BulletController.container_player = _bullet_container_player
	BulletController.container_enemy = _bullet_container_enemy
	player.gun.bullet_container.queue_free()
	player.gun.bullet_container = _bullet_container_player
	player.disappeared.connect(_player_died)
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
	_horde_size = 5 + _level
	# Logarithmic growth, reaching 0.4 on the 10th level.
	_upgrade_chance = Utils.log_base(_level + 1, 11) * 0.4
	# Start the spawner
	spawner.reset_mob_count(10 + _level * 7)
	timer.start()


# Called when the stage is cleared
func _level_finished() -> void:
	BulletController.clear()
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
	StatsController.heal_player(10)
	# Starts the new level
	_new_level()


# Called when the game ends
func _end_game():
	var transition := transition_scene.instantiate()
	transition.message = tr(&"GAME_END")
	transition.target = item_unlock
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	add_sibling(transition)
	queue_free()


# Called when the player dies
func _player_died():
	var transition := transition_scene.instantiate()
	transition.message = tr(&"GAME_DEATH")
	transition.target = main_menu
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	add_sibling(transition)
	queue_free()


## Randomizes all the stats.
## @experimental Temporally avaliable, only for testing purpuses.
func randomize_stats() -> void:
	var s = snapped(randf_range(30.0, 200.0), 0.01)
	var det = snapped(randf_range(0.1, 4.0), 0.01)
	var mh = randi_range(400, 1000)
	var bs = snapped(randf_range(30.0, 200.0), 0.01)
	var bd = randi_range(1, 50)
	var bkf = snapped(randf_range(0.1, 5.0), 0.01)
	var sc = snapped(randf_range(0.01, 1.0), 0.01)
	var stats := StatsClass.Stats.new(StatsClass.MobStats.new(s, det, mh),
			StatsClass.GunStats.new(bs, bd, bkf, sc))
	StatsController.change_stats(stats)
