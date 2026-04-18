class_name Player
extends Mob


## Player sprite.
@export var sprite: Node2D
## Player gun.
@export var gun: Node2D


# Private variables
var _facing: float


# Called when ready
func _ready() -> void:
	_timers[&"last_hit"] = 0.0
	PositionController.update_position(global_position)
	_global_update_stats()
	_global_update_health()
	StatsController.player_stats_must_update.connect(_update_stats)
	StatsController.player_health_must_update.connect(_update_health)


# Updates stat values
func _update_stats(stats: StatsClass.MobStats) -> void:
	speed = stats.speed
	damage_effect_time = stats.damage_effect_time
	max_health = stats.max_health
	_global_update_stats()
	_update_health(health)


# Updates health
func _update_health(new_health: int):
	super(new_health)
	_global_update_health()


# Tells global controller values were changed
func _global_update_stats():
	var stats := StatsClass.MobStats.new(speed, damage_effect_time, max_health)
	StatsController.update_player_stats(stats)


# Tells global controller value was changed
func _global_update_health():
	StatsController.update_player_health(health)


# Called every tick
func _physics_process(delta: float) -> void:
	if not _dead:
		super(delta)
	if _direction.length() > 0:
		PositionController.update_position(global_position)


# Reads input and updates the direction vectors
func _update_direction():
	_direction.x = Input.get_axis("move_left", "move_right")
	_direction.y = Input.get_axis("move_up", "move_down")
	_direction = _direction.limit_length()
	_facing = Input.get_axis("attack_left", "attack_right")


# Updates the sprite animation
func _update_animation():
	if _facing != 0:
		sprite.flip_h = _facing < 0
	if _direction.length() > 0:
		sprite.play("run")
		# Character velocity affects animation velocity
		var scale_value = 0.5 + _direction.length() / 2
		# Character walks backwards when facing the opposite direction
		var scale_sign = -1 if _direction.x < 0 != sprite.flip_h else 1
		sprite.speed_scale = scale_sign * scale_value
	else:
		sprite.play("idle")


# Inherited: Manages a received hit
func take_hit(damage: int, push := Vector2.ZERO):
	if _timers["last_hit"] > damage_effect_time:
		_timers["last_hit"] = 0.0
		super(damage, push)


# Called when health reaches zero
func _die():
	super()
	sprite.play("idle")
	modulate = Constants.DAMAGE_COLOR
	gun.queue_free()
