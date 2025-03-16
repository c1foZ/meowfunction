extends Node2D

@onready var player
@onready var current_scene = get_tree().current_scene.name

func _ready():
	if current_scene == "Level4":
		await get_tree().create_timer(10.0).timeout
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	else:
		await get_tree().create_timer(3.0).timeout  
		player = get_tree().get_nodes_in_group("Player")[0]
		player.can_move = true
		visible = false
		
#func _on_button_pressed() -> void:
	#player = get_tree().get_nodes_in_group("Player")[0]
	##player.can_move = true
	#visible = false
