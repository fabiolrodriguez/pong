extends Node2D

@onready var ball = $ball2D

var score_player = 0
var score_enemy = 0

func _physics_process(delta):

	# gol do player (bola passou o enemy)
	if ball.position.y < -240:
		score_player += 1
		reset_ball()

	# gol do enemy (bola passou o player)
	if ball.position.y > 240:
		score_enemy += 1
		reset_ball()
		
	print("Player: ", score_player, "Enemy: ", score_enemy)

func reset_ball():

	ball.position = Vector2(316,255)

	var dir = Vector2(
		randf_range(-1,1),
		randf_range(-1,1)
	).normalized()

	ball.velocity = dir * ball.speed
