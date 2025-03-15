extends Node

@export var bridge_broken: TileMapLayer
@export var bridge_new: TileMapLayer
@export var bridge_piece: TileMapLayer
@export var bridge_button: Button

signal objective_done

func _on_bridge_button_pressed() -> void:
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
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		var current_size = 16
		rich_text.add_theme_font_size_override("normal_font_size", current_size - 2)
		rich_text.text = "A piece of something. But where does it belong?"
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 


func _on_area_2d_bridge_broken_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "This... isn't complete."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 


func _on_area_2d_body_new_bridge_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and bridge_new.visible == true:
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Now it makes sense."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false
		bridge_new.get_node("Area2D").queue_free()
