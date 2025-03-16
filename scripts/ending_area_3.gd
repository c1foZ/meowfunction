extends Area2D

const FILE_BEGIN = "res://scenes/levels/level_"
@onready var player = $"../Player3"
@export var end_button: Button

func _on_body_entered(body: Node2D) -> void:
	var points = player.total_objectives
	if body.is_in_group("Player3") and points == 2:
		var dialog_node = body.get_node("Dialog3")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "A fracture too deep to repair... or is it?"
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 
		end_button.disabled = false
		
		#var current_scene_file = get_tree().current_scene.scene_file_path
		#var next_level_number = current_scene_file.to_int() + 1
		#
		#var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		#
		#call_deferred("change_scene", next_level_path)
	else:
		var dialog_node = body.get_node("Dialog3")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		#var current_size = 16
		#rich_text.add_theme_font_size_override("normal_font_size", current_size - 3.1)
		rich_text.text = "I can't go there yet."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 
		dialog_node.visible = true
		rich_text.text = "There's still something left behind."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 

func change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)


func _on_button_pressed() -> void:
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
		
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		
	call_deferred("change_scene", next_level_path)
