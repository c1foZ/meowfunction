extends StaticBody2D

@onready var audio = $AudioStreamPlayer2D
@onready var animated_open = $AnimatedSprite2D
@export var walls: TileMapLayer
@export var button: Button
@onready var area = $Area2D

signal objective_done

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player2"):
		animated_open.play("open")
		audio.play()

func _on_button_pressed() -> void:
	walls.visible = true
	button.disabled = true
	animated_open.stop()
	audio.stop()
	area.queue_free()
	emit_signal("objective_done")
