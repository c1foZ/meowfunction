extends CharacterBody2D

@export var speed = 3
@onready var animation_player = $AnimatedSprite2D
@onready var audio_meow = $MeowAudio

@onready var objectives = $Objectives
var total_objectives = 0

var last_direction = "right"
var can_move = true

signal objective_done

@export var small_cat_scene: PackedScene

var next_meow_time = 0
var meow_timer = 0.0

func _physics_process(delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		return
		
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

func _on_dialog_tree_entered() -> void:
	can_move = false

func _on_objective_done() -> void:
	total_objectives += 1
	var rich_text = objectives.get_node("RichTextLabel")
	rich_text.text = str(total_objectives) + "/4"

func _on_button_pressed() -> void:
	var small_cat_instance = small_cat_scene.instantiate()  # ✅ Create the instance
	add_child(small_cat_instance)  # ✅ Attach it to the current node (e.g., Player)
	small_cat_instance.position = Vector2(0, -25)

func _on_parent_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player2") and has_node("SmallCat"):
		var small_cat = get_node("SmallCat")
		small_cat.queue_free()
		var new_small_cat = get_tree().get_nodes_in_group("NewSmallCat")[0]
		new_small_cat.visible = true
		emit_signal("objective_done")
		var dialog_node = body.get_node("Dialog2")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Safe. A family complete. For now."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false
		var parent_area = get_tree().get_first_node_in_group("ParentArea")
		parent_area.queue_free()
	elif body.is_in_group("Player2"):
		var dialog_node = body.get_node("Dialog2")
		dialog_node.visible = true
		var rich_text = dialog_node.get_node("RichTextLabel")
		rich_text.text = "Their eyes search past me."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false
		dialog_node.visible = true
		rich_text.text = "They're waiting for something else."
		await get_tree().create_timer(3.0).timeout
		dialog_node.visible = false
