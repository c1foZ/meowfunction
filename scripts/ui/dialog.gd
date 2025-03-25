extends Node2D

@onready var player
@onready var current_scene = get_tree().current_scene.name
@export var broken_audio: AudioStreamPlayer2D

func _ready():
	if current_scene == "Level4":
		MusicManager.music_player.stream = broken_audio.stream
		MusicManager.music_player.play()
		
		var ground = get_tree().get_first_node_in_group("Ground")
		var tween = get_tree().create_tween()
		tween.tween_property(ground, "modulate:a", 1, 1.5)  # ✅ Fade to black over 1.5 sec
		await tween.finished
		
		await get_tree().create_timer(10.0).timeout
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	else:
		await get_tree().create_timer(2.0).timeout
		player = get_tree().get_nodes_in_group("Player")[0]
		player.can_move = true
		visible = false

#func _on_button_pressed() -> void:
	#player = get_tree().get_nodes_in_group("Player")[0]
	##player.can_move = true
	#visible = false
