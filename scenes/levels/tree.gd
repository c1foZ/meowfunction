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
