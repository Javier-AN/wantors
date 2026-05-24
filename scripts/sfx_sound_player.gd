extends SoundPlayer


func _on_node_added(node: Node) -> void:
	if node is Player:
		node.hit.connect(_play_player_hit)
		node.died.connect(_play_player_died)
	elif node is Creature:
		node.hit.connect(_play_creature_hit)
		node.died.connect(_play_creature_died)
	elif node is PlayerGun:
		node.shot.connect(_play_player_shot)
	elif node is EnemyGun:
		node.shot.connect(_play_creature_shot)


func _play_player_hit() -> void:
	play(preload("res://assets/sfx/damage1.ogg"))

func _play_player_died() -> void:
	play(preload("res://assets/sfx/die1.ogg"))

func _play_player_shot() -> void:
	play(preload("res://assets/sfx/shoot1.ogg"))

func _play_creature_hit() -> void:
	play(preload("res://assets/sfx/damage2.ogg"))

func _play_creature_died() -> void:
	play(preload("res://assets/sfx/die2.ogg"))

func _play_creature_shot() -> void:
	play(preload("res://assets/sfx/shoot2.ogg"))
