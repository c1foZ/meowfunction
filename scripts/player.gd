extends CharacterBody2D

@export var speed = 3
@onready var animation_player = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
	if direction != Vector2.ZERO:
		animation_player.play("walk-right")
	else:
		animation_player.play("idle-right")
		
