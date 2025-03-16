extends Node

@export var broken_path: TileMapLayer
@export var fixed_path: TileMapLayer
@export var path_button: Button

signal objective_done


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player2"):
		var dialog_node = body.get_node("Dialog2")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		var current_size = 16
		rich_text.add_theme_font_size_override("normal_font_size", current_size - 2)
		rich_text.text = "Fragments of a path, scattered and forgotten."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 
		dialog_node.visible = true
		rich_text.text = "Could they ever fit together?"
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 


func _on_path_button_pressed() -> void:
	path_button.disabled = true
	path_button.queue_free()
	emit_signal("objective_done")
	broken_path.visible = false
	fixed_path.visible = true
	broken_path.get_node("Area2D").queue_free()
	
	var body = get_tree().get_nodes_in_group("Player2")[0]
	var dialog_node = body.get_node("Dialog2")
	dialog_node.visible = true
	var rich_text = dialog_node.get_node("RichTextLabel")
	var current_size = 16
	rich_text.add_theme_font_size_override("normal_font_size", current_size - 3)
	rich_text.text = "The path is whole, yet it leads into the unknown..."
	await get_tree().create_timer(3.0).timeout
	dialog_node.visible = false 
	dialog_node.visible = true
	rich_text.text = "...something feels off."
	await get_tree().create_timer(3.0).timeout
	dialog_node.visible = false 
