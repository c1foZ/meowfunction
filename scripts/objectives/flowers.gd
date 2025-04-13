extends Node

@export var flower_broken: TileMapLayer
@export var flower_new: TileMapLayer
@export var flower_button: Button

signal objective_done

var player_ref: Node2D
var in_area := false

func _on_flower_button_pressed() -> void:
	if in_area:
		emit_signal("objective_done")
		flower_button.disabled = true
		flower_broken.queue_free()

		flower_new.visible = true
		flower_button.disabled = true
		flower_button.queue_free()

		var body = get_tree().get_nodes_in_group("Player")[0]
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "That's better. But why did it bother me?"
		body.can_move = false
		await get_tree().create_timer(0.01).timeout
		in_area = true
		set_process_input(true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = true
		player_ref = body
		player_ref.can_move = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Something feels... off."
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
