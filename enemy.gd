extends AnimatableBody2D

@export var speed = 200
@onready var ball = get_node("../ball2D")
@export var min_x = 60.0
@export var max_x = 580.0

func _physics_process(delta):

	var target_x = ball.global_position.x
	
	if target_x > global_position.x:
		position.x += speed * delta
	elif target_x < global_position.x:
		position.x -= speed * delta

		
#func _physics_process(delta):
	#position.x += 100 * delta
	
