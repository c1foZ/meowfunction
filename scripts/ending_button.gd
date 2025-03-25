extends Node

@export var ending_btn: TileMapLayer
@export var ending_btn_pressed: TileMapLayer


func _on_area_2d_body_entered(body: Node2D) -> void:
	ending_btn.queue_free()
	ending_btn_pressed.visible = true
	
