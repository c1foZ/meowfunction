extends Node2D

@onready var player

func _on_button_pressed() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	player.can_move = true
	visible = false
