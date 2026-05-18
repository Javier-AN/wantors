class_name Player
extends Mob
## A mob controlled by the player.

#region Variables
# Indicates the direction the player is looking at.
var _facing: float
# Indicates whether the player is invulnerable to damage.
var _invulnerable: bool

# Player gun.
@onready var _gun: Node2D = $PlayerGun
# Player sprite.
@onready var _sprite: AnimatedSprite2D = $Sprite
# Invulnerability timer.
@onready var _timer := Timer.new()
#endregion


#region Methods

# Called when ready.
func _ready() -> void:
	add_child(_timer)
	_timer.timeout.connect(_end_invulnerability)
	PositionController.update_position(global_position)
	_global_update_stats()
	_global_update_health()
	StatsController.player_stats_must_update.connect(_update_stats)
	StatsController.player_health_must_update.connect(_update_health)


#region Movement and animation

# Called every tick
func _physics_process(delta: float) -> void:
	super(delta)
	if velocity.length() > 0:
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
		_sprite.flip_h = _facing < 0
	if _direction.length() > 0:
		_sprite.play("run")
		# Character velocity affects animation velocity
		var scale_value = 0.5 + _direction.length() / 2
		# Character walks backwards when facing the opposite direction
		var scale_sign = -1 if _direction.x < 0 != _sprite.flip_h else 1
		_sprite.speed_scale = scale_sign * scale_value
	else:
		_sprite.play("idle")

#endregion


#region Stats and health

func take_hit(damage: int, push := Vector2.ZERO) -> void:
	if not _invulnerable:
		_invulnerable = true
		super(damage, push)
		_timer.start(damage_effect_time)


func _end_invulnerability() -> void:
	_invulnerable = false


# Updates self stat values.
func _update_stats(stats: StatsClass.MobStats) -> void:
	speed = stats.speed
	damage_effect_time = stats.damage_effect_time
	max_health = stats.max_health
	_global_update_stats()
	_update_health(health)


# Updates self health.
func _update_health(new_health: int):
	super(new_health)
	_global_update_health()


# Tells global controller values were changed.
func _global_update_stats():
	var stats := StatsClass.MobStats.new(speed, damage_effect_time, max_health)
	StatsController.update_player_stats(stats)


# Tells global controller value was changed.
func _global_update_health():
	StatsController.update_player_health(health)


# Called when health reaches zero.
func _die():
	super()
	_sprite.play("idle")
	modulate = Constants.DAMAGE_COLOR
	if _gun:
		_gun.queue_free()

#endregion

#endregion
