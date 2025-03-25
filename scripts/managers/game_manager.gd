extends Node

const FILE_BEGIN = "res://scenes/levels/level_"

func _ready():
	print("GameManager initialized")

func next_level() -> void:
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"

	call_deferred("change_scene", next_level_path)

func change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
