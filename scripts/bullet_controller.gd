extends Node

var container_player: Node2D
var container_enemy: Node2D


func clear() -> void:
	clear_player()
	clear_enemy()


func clear_player() -> void:
	var children = container_player.get_children()
	for child in children:
		child.queue_free()


func clear_enemy() -> void:
	var children = container_enemy.get_children()
	for child in children:
		child.queue_free()
