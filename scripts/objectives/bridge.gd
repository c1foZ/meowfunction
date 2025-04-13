extends Node

@export var bridge_broken: TileMapLayer
@export var bridge_new: TileMapLayer
@export var bridge_piece: TileMapLayer
@export var bridge_button: Button

signal objective_done

var player_ref: Node2D
var in_area := false

func _on_bridge_button_pressed() -> void:
	if in_area:
		emit_signal("objective_done")
		bridge_button.disabled = true
		bridge_piece.queue_free()
		bridge_broken.queue_free()
		bridge_new.visible = true
		bridge_new.get_node("Area2D").visible = true
		bridge_new.get_node("Area2D").get_node("CollisionShape2D").visible = true
		bridge_piece.get_node("Area2DBridgePiece").queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = true
		player_ref = body
		player_ref.can_move = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabelBigger")
		dialog_node.get_node("Sprite2D").visible = false
		dialog_node.get_node("RichTextLabel").visible = false
		dialog_node.get_node("Sprite2DBigger").visible = true
		dialog_node.get_node("RichTextLabelBigger").visible = true
		rich_text.text = "A piece of something. But where does it belong?"
		set_process_input(true)

func _on_area_2d_bridge_piece_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.get_node("Sprite2D").visible = true
		dialog_node.get_node("RichTextLabel").visible = true
		dialog_node.get_node("Sprite2DBigger").visible = false
		dialog_node.get_node("RichTextLabelBigger").visible = false
		
func _on_area_2d_bridge_broken_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = true
		player_ref = body
		player_ref.can_move = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "This... isn't complete."
		set_process_input(true)

func _on_area_2d_bridge_broken_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = false

func _on_area_2d_body_new_bridge_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and bridge_new.visible == true:
		in_area = true
		player_ref = body
		player_ref.can_move = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Now it makes sense."
		set_process_input(true)

func _on_area_2d_body_new_bridge_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and bridge_new.visible == true:
		bridge_new.get_node("Area2D").queue_free()
		in_area = false

func _input(event):
	if in_area and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var dialog_node = player_ref.get_node("Dialog")
		dialog_node.visible = false
		player_ref.can_move = true
		set_process_input(false)
