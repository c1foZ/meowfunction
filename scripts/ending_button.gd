extends Node

@export var ending_btn: TileMapLayer
@export var ending_btn_pressed: TileMapLayer
@onready var player = $"../Player"

func _on_area_2d_body_entered(body: Node2D) -> void:
	var points = player.total_objectives
	if body.is_in_group("Player") and points == 4:
		ending_btn.visible = false
		ending_btn_pressed.visible = true
