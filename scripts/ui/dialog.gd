extends Node2D

@onready var player
@onready var current_scene = get_tree().current_scene.name
@export var broken_audio: AudioStreamPlayer2D

var dialog_visible := false
var player_ref: Node2D

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
		player = get_tree().get_nodes_in_group("Player")[0]
		player_ref = player
		set_process_input(true) 

func _input(event):
	if visible and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var dialog_node = player_ref.get_node("Dialog")
		dialog_node.visible = false
		player_ref.can_move = true
		dialog_visible = false
		set_process_input(false)
		
#func _on_button_pressed() -> void:
	#player = get_tree().get_nodes_in_group("Player")[0]s
	##player.can_move = true
	#visible = false
