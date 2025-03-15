extends CharacterBody2D

@onready var cat_audio = $BirdSound
@onready var animation_player = $AnimatedSprite2D
@onready var meow_sound = $MeowSound

func _process(_delta):
	animation_player.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		cat_audio.play()

func _on_button_pressed() -> void:
	cat_audio.stream = meow_sound.stream
	cat_audio.play()
