extends Area2D

const FILE_BEGIN = "res://scenes/levels/level_"
@onready var player = $"../Player"

func _on_body_entered(body: Node2D) -> void:
	var points = player.total_objectives
	if body.is_in_group("Player") and points == 4:
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1

		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"

		call_deferred("change_scene", next_level_path)
	else:
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		var current_size = 16
		rich_text.add_theme_font_size_override("normal_font_size", current_size - 3.1)
		rich_text.text = "I can't go there yet. There's still something left behind."
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false

func change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
