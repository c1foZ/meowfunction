extends Area2D

const FILE_BEGIN = "res://scenes/levels/level_"
@onready var player = $"../Player"

var player_ref: Node2D
var in_area := false

func _on_body_entered(body: Node2D) -> void:
	var points = player.total_objectives
	if body.is_in_group("Player") and points == 4:
		body.can_move = false
		var tween = get_tree().create_tween()
		tween.tween_property(player, "modulate:a", 0, 1.5)
		await tween.finished

		GameManager.next_level()

	elif body.is_in_group("Player") and points != 4:
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
		rich_text.text = "I can't go there yet. There's still something left behind."
		set_process_input(true)

func _on_big_ending_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.get_node("Sprite2D").visible = true
		dialog_node.get_node("RichTextLabel").visible = true
		dialog_node.get_node("Sprite2DBigger").visible = false
		dialog_node.get_node("RichTextLabelBigger").visible = false
		
func _input(event):
	if in_area and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var dialog_node = player_ref.get_node("Dialog")
		dialog_node.visible = false
		player_ref.can_move = true
		set_process_input(false)
