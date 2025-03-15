extends Node

@export var old_tree: Node
@export var new_tree: Node
@export var tree_button: Button

func _on_tree_button_pressed() -> void:
	print("Tree button is pressed")
	tree_button.disabled = true

	var tween = get_tree().create_tween()

	if old_tree:
		old_tree.visible = false  # Hide after fade-out

	if new_tree:
		new_tree.modulate.a = 0  # Start fully transparent
		new_tree.visible = true
		tween.tween_property(new_tree, "modulate:a", 1, 0.5)  # Fade in
	
	var body = get_tree().get_nodes_in_group("Player")[0]
	var dialog_node = body.get_node("Dialog")
	dialog_node.visible = true
	var rich_text = dialog_node.get_node("RichTextLabel")
	var current_size = rich_text.get_theme_font_size("normal_font_size")
	rich_text.add_theme_font_size_override("normal_font_size", current_size - 2)
	rich_text.text = "Standing tall again. Was it meant to fall?"
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "It wasn't always like this."
		old_tree.get_node("Area2D").queue_free()

		
		
