extends Node

@export var axe: Sprite2D
@export var axe_scene: PackedScene
@export var fence_button: Button
@export var closed_fence: TileMapLayer

signal axe_discard

func _on_fence_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player3"):
		var dialog_node = body.get_node("Dialog3")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "The fence stands in my way..."
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
		dialog_node.visible = true
		rich_text.text = "But what if something could cut through it?"
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false

func _on_axe_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player3"):
		var dialog_node = body.get_node("Dialog3")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "A tool for cutting through wood..."
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
		dialog_node.visible = true
		rich_text.text = "might come in handy."
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false


func _on_axe_button_pressed() -> void:
	var body = get_tree().get_nodes_in_group("Player3")[0]
	var axe_instance = axe_scene.instantiate()
	body.add_child(axe_instance)
	axe_instance.position = Vector2(0, -30)
	axe.queue_free()
	if has_node("AxeButton"):
		get_node("AxeButton").queue_free()
	if has_node("AxeArea2D"):
		get_node("AxeArea2D").queue_free()
	fence_button.disabled = false


func _on_fence_button_pressed() -> void:
	closed_fence.queue_free()
	if has_node("FenceButton"):
		get_node("FenceButton").queue_free()
	if has_node("FenceArea2D"):
		get_node("FenceArea2D").queue_free()
	emit_signal("axe_discard")
