extends CharacterBody2D

@onready var bird_audio = $BirdSound
@onready var animation_player = $AnimatedSprite2D

func _process(_delta):
	animation_player.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		bird_audio.play()
