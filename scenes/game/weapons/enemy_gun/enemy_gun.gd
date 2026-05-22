class_name EnemyGun
extends Gun
## An IA controlled gun.

## Direction the gun faces.
var direction := Vector2.ZERO


# Called when ready.
func _ready() -> void:
	bullet_container = BulletController.container_enemy
	super()


# Called every tick.
func _physics_process(_delta: float) -> void:
	rotation = direction.angle()
	shoot()
