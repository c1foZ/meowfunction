extends Node

@onready var music_player = $BrokenMusic  

func _ready():
	if music_player == null:
		print("Error: AudioStreamPlayer not found!")
		return
		
	if not get_tree().has_meta("music_initialized"):
		get_tree().set_meta("music_initialized", true)
		music_player.play()
	else:
		queue_free()
