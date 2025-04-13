extends Node

@export var old_tree: Node
@export var new_tree: Node
@export var tree_button: Button

signal objective_done

var player_ref: Node2D
var in_area := false
var button_is_pressed := false

func _on_tree_button_pressed() -> void:
	if in_area:
		emit_signal("objective_done")
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
		body.can_move= false
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Standing tall again. Was it meant to fall?"
		button_is_pressed = true
		set_process_input(true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = true
		player_ref = body
		player_ref.can_move = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "It wasn't always like this."
		set_process_input(true) 
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = false 
		
func _input(event):
	if in_area and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var dialog_node = player_ref.get_node("Dialog")
		dialog_node.visible = false
		player_ref.can_move = true
		set_process_input(false)
		if button_is_pressed:
			old_tree.get_node("Area2D").queue_free()
