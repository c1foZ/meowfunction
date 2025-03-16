extends CharacterBody2D

@onready var cat_audio = $BirdSound
@onready var animation_player = $AnimatedSprite2D
@onready var meow_sound = $MeowSound
@onready var button = $Button

signal objective_done

func _process(_delta):
	animation_player.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		cat_audio.play()
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		if cat_audio.stream == meow_sound.stream:
			rich_text.text = "That's... better?"
		else:
			rich_text.text = "Wait... did that cat just chirp?"
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false


func _on_button_pressed() -> void:
	emit_signal("objective_done")
	button.disabled = true
	cat_audio.stream = meow_sound.stream
	cat_audio.play()
	var body = get_tree().get_nodes_in_group("Player")[0]
	var dialog_node = body.get_node("Dialog")
	dialog_node.visible = true
	var rich_text = dialog_node.get_node("RichTextLabel")
	rich_text.text = "That's... better?"
	await get_tree().create_timer(2.0).timeout
	dialog_node.visible = false
