extends Node

@export var flower_broken: TileMapLayer
@export var flower_new: TileMapLayer
@export var flower_button: Button

func _on_flower_button_pressed() -> void:
	flower_button.disabled = true
	flower_broken.queue_free()
	
	var tween = get_tree().create_tween()
	flower_new.modulate.a = 0  # Start fully transparent
	flower_new.visible = true
	tween.tween_property(flower_new, "modulate:a", 1, 0.5)  # Fade in
	
	 # Highlight the button before disabling it
	flower_button.modulate = Color(1, 1, 0)  # Change to yellow for highlight
	await get_tree().create_timer(0.2).timeout  # Wait for highlight effect
