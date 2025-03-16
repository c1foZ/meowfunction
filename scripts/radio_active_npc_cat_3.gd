extends CharacterBody2D

@onready var animation_player = $AnimatedSprite2D
@export var button: Button

signal objective_done

func _process(_delta):
	animation_player.play("idle")


func _on_button_pressed() -> void:
	button.disabled = true
	button.queue_free()
	emit_signal("objective_done")
	if has_node("Area2D"):
		get_node("Area2D").queue_free()

	var body = get_tree().get_nodes_in_group("Player3")[0]
	var dialog_node = body.get_node("Dialog3")
	dialog_node.visible = true
	var rich_text = dialog_node.get_node("RichTextLabel")
	rich_text.text = "Weird..."
	await get_tree().create_timer(2.0).timeout
	dialog_node.visible = false
	await get_tree().create_timer(2.0).timeout
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player3"):
		var dialog_node = body.get_node("Dialog3")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Is that... glowing?"
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
