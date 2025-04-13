extends CharacterBody2D

@onready var cat_audio = $BirdSound
@onready var animation_player = $AnimatedSprite2D
@onready var meow_sound = $MeowSound
@onready var button = $Button

signal objective_done

var player_ref: Node2D
var in_area := false
var button_is_pressed := false

func _process(_delta):
	animation_player.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = true
		cat_audio.play()
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		player_ref = body
		player_ref.can_move = false
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Wait... did that cat just chirp?"
		set_process_input(true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_area = false

func _on_button_pressed() -> void:
	if in_area:
		emit_signal("objective_done")
		button.disabled = true
		cat_audio.stream = meow_sound.stream
		cat_audio.play()
		var body = get_tree().get_nodes_in_group("Player")[0]
		body.can_move = false
		var dialog_node = body.get_node("Dialog")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "That's... better?"
		button_is_pressed = true
		set_process_input(true)

func _input(event):
	if in_area and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var dialog_node = player_ref.get_node("Dialog")
		dialog_node.visible = false
		player_ref.can_move = true
		set_process_input(false)
		if button_is_pressed:
			get_node("Area2D").queue_free()
