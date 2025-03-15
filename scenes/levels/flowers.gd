extends Node

@export var flower_broken: TileMapLayer
@export var flower_new: TileMapLayer
@export var flower_button: Button

func _on_flower_button_pressed() -> void:
	flower_button.disabled = true
	flower_broken.queue_free()
	
	var tween = get_tree().create_tween()
	flower_new.modulate.a = 0  # Start fully transparent
	flower_new.visible = true
	tween.tween_property(flower_new, "modulate:a", 1, 0.5)  # Fade in
	
	 # Highlight the button before disabling it
	flower_button.modulate = Color(1, 1, 0)  # Change to yellow for highlight
	await get_tree().create_timer(0.2).timeout  # Wait for highlight effect
	
	var body = get_tree().get_nodes_in_group("Player")[0]
	var dialog_node = body.get_node("Dialog")
	dialog_node.visible = true
	var rich_text = dialog_node.get_node("RichTextLabel")
	rich_text.text = "That's better. But why did it bother me?"
	await get_tree().create_timer(3.0).timeout
	dialog_node.visible = false 


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Something feels... off."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 
