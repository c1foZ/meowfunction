extends StaticBody2D

@onready var audio = $AudioStreamPlayer2D
@onready var animated_open = $AnimatedSprite2D
@export var walls: TileMapLayer
@export var button: Button
@onready var area = $Area2D

signal objective_done

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player2"):
		animated_open.play("open")
		audio.play()
		var dialog_node = body.get_node("Dialog2")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		var current_size = 16
		rich_text.add_theme_font_size_override("normal_font_size", current_size - 3)
		rich_text.text = "A chest that won't stay closed... or won't stay open?"
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false 

func _on_button_pressed() -> void:
	walls.visible = true
	button.disabled = true
	animated_open.stop()
	audio.stop()
	area.queue_free()
	emit_signal("objective_done")
	
	var body = get_tree().get_nodes_in_group("Player2")[0]
	var dialog_node = body.get_node("Dialog2")
	dialog_node.visible = true
	var rich_text = dialog_node.get_node("RichTextLabel")
	#var current_size = 16
	#rich_text.add_theme_font_size_override("normal_font_size", current_size - 7)
	rich_text.text = "The chest is closed, but the windows are missing."
	await get_tree().create_timer(3.0).timeout
	dialog_node.visible = false 
	dialog_node.visible = true
	rich_text.text = "What was there... is no longer meant to be seen."
	await get_tree().create_timer(3.0).timeout
	dialog_node.visible = false 
	
