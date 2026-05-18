class_name PlayerGun
extends Gun
## A gun controlled by the player.

# Private variables
var _direction: Vector2


#region Stats

# Called when ready
func _ready() -> void:
	super()
	_global_update_stats()
	StatsController.gun_stats_must_update.connect(_update_stats)


# Updates stat values
func _update_stats(stats: StatsClass.GunStats) -> void:
	bullet_speed = stats.bullet_speed
	bullet_damage = stats.bullet_damage
	bullet_knockback_factor = stats.bullet_knockback_factor
	shooting_cooldown = stats.shooting_cooldown
	_global_update_stats()


# Tells global controller values were changed
func _global_update_stats():
	var stats := StatsClass.GunStats.new(bullet_speed, bullet_damage,
			bullet_knockback_factor, shooting_cooldown)
	StatsController.update_gun_stats(stats)

#endregion


# Called every tick
func _physics_process(_delta: float) -> void:
	_get_input()
	if _direction.length() > 0:
		rotation = _direction.angle()
		shoot()


# Reads input and updates the direction vector
func _get_input():
	_direction.x = Input.get_axis("attack_left", "attack_right")
	_direction.y = Input.get_axis("attack_up", "attack_down")
