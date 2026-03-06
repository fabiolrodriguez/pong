extends CharacterBody2D

@export var speed = 300
@export var posicao : Vector2
var start_position : Vector2
@onready var placar = get_node("../CanvasLayer/placar")
@onready var winner = get_node("../CanvasLayer2/winner")

var gols_player = 0
var gols_enemy = 0

func _ready():
	velocity = Vector2(1,1).normalized() * speed
	start_position = global_position
	reset_ball()	

func atualizar_placar():
	placar.text = "%s x %s" % [gols_player, gols_enemy]
	
func reset_ball():
	# volta para a posição inicial
	global_position = start_position

	# define nova direção
	velocity = Vector2(1,1).normalized() * speed
	
func checar_vitoria():

	if gols_player >= 5:
		winner.text = "VOCÊ VENCEU"
		get_tree().paused = true

	if gols_enemy >= 5:
		winner.text = "ADVERSÁRIO VENCEU"
		get_tree().paused = true	

func _physics_process(delta):

	var collision = move_and_collide(velocity * delta)

	if collision:
		velocity = velocity.bounce(collision.get_normal())
		posicao = global_position
		
		var collider = collision.get_collider()

		if collider.name == "gol_enemy":
			gols_player = gols_player + 1
			atualizar_placar()
			checar_vitoria()
			reset_ball()
			
		if collider.name == "gol_player":
			gols_enemy = gols_enemy + 1
			atualizar_placar()
			checar_vitoria()
			reset_ball()
