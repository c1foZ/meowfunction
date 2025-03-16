extends Node

@onready var star_audio = $StarButton/AudioStreamPlayer2D
@onready var king_audio = $KingButton/AudioStreamPlayer2D
@onready var sun_audio = $SunButton/AudioStreamPlayer2D

@export var star_button: Button

@onready var fixed_melody = $FixedMelody

signal objective_done

var correct_sequence = ["King", "Star", "Sun"]  # ✅ The correct order
var player_sequence = []  # ✅ Stores what the player presses

func _on_star_button_pressed() -> void:
	star_audio.play()
	check_sequence("Star")  # ✅ Add to player's input

func _on_king_button_pressed() -> void:
	king_audio.play()
	check_sequence("King")

func _on_sun_button_pressed() -> void:
	sun_audio.play()
	check_sequence("Sun")

func check_sequence(button_name: String) -> void:
	player_sequence.append(button_name)  # ✅ Add pressed button to sequence

	# ✅ Check if the sequence is correct so far
	for i in range(player_sequence.size()):
		if player_sequence[i] != correct_sequence[i]:
			print("Wrong sequence! Try again.")
			player_sequence.clear()  # Reset input if incorrect
			
			var body = get_tree().get_nodes_in_group("Player2")[0]
			var dialog_node = body.get_node("Dialog2")
			dialog_node.visible = true
			var rich_text = dialog_node.get_node("RichTextLabel")
			rich_text.text = "The notes scatter, refusing to align"
			await get_tree().create_timer(2.0).timeout
			dialog_node.visible = false
			dialog_node.visible = true
			rich_text.text = "Try again?"
			await get_tree().create_timer(2.0).timeout
			dialog_node.visible = false
			return

	# ✅ If the sequence is complete and correct
	if player_sequence == correct_sequence:
		print("Success! You played the correct order.")
		player_sequence.clear()  # Reset for next time

		MusicManager.music_player.stream = fixed_melody.stream
		MusicManager.music_player.play()

		emit_signal("objective_done")

		var body = get_tree().get_nodes_in_group("Player2")[0]
		var dialog_node = body.get_node("Dialog2")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Harmony... but for how long?"
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
		star_button.disabled = true
		if has_node("Area2D"):
			var area = get_node("Area2D")
			area.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player2"):
		var dialog_node = body.get_node("Dialog2")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "The sound feels... off."
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
		dialog_node.visible = true
		rich_text.text = "Maybe these notes are meant to be"
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
		dialog_node.visible = true
		rich_text.text = "played in a certain order?"
		await get_tree().create_timer(2.0).timeout
		dialog_node.visible = false
