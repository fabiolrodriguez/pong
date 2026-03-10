#extends CharacterBod
extends CharacterBody2D

@export var speed = 400
@onready var player = get_node("./Sprite2D")

func flash_hit():

	player.modulate = Color(0.844, 0.747, 0.402, 1.0)
	
	await get_tree().create_timer(0.2).timeout
	
	player.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _physics_process(delta):

	var direction = 0

	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1

	velocity.x = direction * speed
	velocity.y = 0

	move_and_slide()
