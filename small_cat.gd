extends Node2D

@onready var animation_player = $AnimatedSprite2D
@export var small_cat_button: Button

func _process(_delta):
	animation_player.play("idle")


func _on_button_pressed() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player2"):
		var dialog_node = body.get_node("Dialog2")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Tucked away, quiet and still."
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
		dialog_node.visible = true
		rich_text.text = "Waiting... or forgotten?"
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
		small_cat_button.disabled = false
