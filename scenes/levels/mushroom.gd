extends Node

signal stop_opacity
signal objective_done

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player3"):
		var dialog_node = body.get_node("Dialog3")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "This could be the answer..."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 
		dialog_node.visible = true
		rich_text.text = "Will it stop me from fading?"
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 


func _on_button_pressed() -> void:
	if has_node("Button"):
		get_node("Button").queue_free()
	if has_node("Area2D"):
		get_node("Area2D").queue_free()
	emit_signal("stop_opacity")
	emit_signal("objective_done")
	
	var body = get_tree().get_nodes_in_group("Player3")[0]
	var dialog_node = body.get_node("Dialog3")
	dialog_node.visible = true
	var rich_text = dialog_node.get_node("RichTextLabel")
	rich_text.text = "I'm whole again..."
	await get_tree().create_timer(3.0).timeout
	dialog_node.visible = false
