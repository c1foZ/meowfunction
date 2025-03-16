extends Node2D

@onready var animation_player = $AnimatedSprite2D

func _process(_delta):
	animation_player.play("idle")


func _on_button_pressed() -> void:
	queue_free()
