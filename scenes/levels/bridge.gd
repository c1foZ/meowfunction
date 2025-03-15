extends Node

@export var bridge_broken: TileMapLayer
@export var bridge_new: TileMapLayer
@export var bridge_piece: TileMapLayer
@export var bridge_button: Button


func _on_bridge_button_pressed() -> void:
	bridge_button.disabled = true
	bridge_piece.queue_free()
	bridge_broken.queue_free()
	bridge_new.visible = true
