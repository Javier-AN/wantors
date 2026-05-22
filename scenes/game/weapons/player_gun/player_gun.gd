class_name PlayerGun
extends Gun
## A gun controlled by the player.

## Direction the gun is facing. Automatically updated through input.
var direction := Vector2.ZERO
## Indicates if the gun is facing right. Automatically updated through input.
var facing_right: bool = true


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
	if direction.length() > 0:
		facing_right = direction.x >= 0
		rotation = direction.angle()
		shoot()


# Reads input and updates the direction vector
func _input(_event: InputEvent) -> void:
	direction.x = Input.get_axis("attack_left", "attack_right")
	direction.y = Input.get_axis("attack_up", "attack_down")
