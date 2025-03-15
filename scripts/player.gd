extends CharacterBody2D

@export var speed = 3
@onready var animation_player = $AnimatedSprite2D
@onready var audio_meow = $MeowAudio

var last_direction = "right"

var next_meow_time = 0
var meow_timer = 0.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	meow_timer += delta
	
	if meow_timer >= next_meow_time:
		play_meow()
	
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		animation_player.play("walk_up")
		last_direction = "up"
	elif Input.is_action_pressed("move_down"):
		direction.y += 1
		animation_player.play("walk_down")
		last_direction = "down"
	elif Input.is_action_pressed("move_right"):
		direction.x += 1
		animation_player.play("walk_right")
		last_direction = "right"
	elif Input.is_action_pressed("move_left"):
		direction.x -= 1
		animation_player.play("walk_left")
		last_direction = "left"
	else:
		animation_player.play("idle_" + last_direction)
		
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
func play_meow():
	if not audio_meow.playing:
		audio_meow.play()
		meow_timer = 0.0
		next_meow_time = randi_range(10, 20)
