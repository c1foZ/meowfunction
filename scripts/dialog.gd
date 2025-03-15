extends Node2D

@onready var player

func _ready():
	await get_tree().create_timer(3.0).timeout  
	player = get_tree().get_nodes_in_group("Player")[0]
	player.can_move = true
	visible = false
		
func _on_button_pressed() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	#player.can_move = true
	visible = false
