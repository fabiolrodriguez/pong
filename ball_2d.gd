extends CharacterBody2D

@export var speed = 300
@export var posicao : Vector2
var start_position : Vector2
@onready var placar = get_node("../CanvasLayer/placar")
@onready var victory_panel = get_node("../CanvasLayer2/VictoryPanel")
@onready var winner = get_node("../CanvasLayer2/VictoryPanel/winner")
@onready var hit_sound = $AudioStreamPlayer2D
@onready var hit_goal = $AudioStreamPlayerGoal
@onready var hit_victory = $AudioStreamPlayerVictory
@onready var hit_lose = $AudioStreamPlayerLose
@export var speed_increment = 8.0
@export var max_speed = 320.0
@export var min_vertical_ratio = 0.35

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
	randomize()
	start_position = global_position
	reset_ball()
	victory_panel.visible = false

func atualizar_placar():
	placar.text = "%s x %s" % [gols_player, gols_enemy]
	
func reset_ball():
	global_position = start_position

	var dir_x = [-1, 1].pick_random()
	var dir_y = randf_range(-0.6, 0.6)

	var dir = Vector2(dir_x, dir_y).normalized()
	
	speed = 300

	velocity = dir * speed

func mostrar_tela_final(texto: String):
	winner.text = texto
	victory_panel.visible = true
	get_tree().paused = true	
	
func checar_vitoria():

	if gols_player >= 5:
		mostrar_tela_final("VOCÊ VENCEU")
		hit_victory.play()
	if gols_enemy >= 5:
		hit_lose.play()
		mostrar_tela_final("ADVERSÁRIO VENCEU")
		
func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_quit_button_pressed():
	get_tree().quit()

func sign_nonzero(value: float) -> float:
	return -1.0 if value < 0.0 else 1.0
		
func _fix_ball_angle(v: Vector2) -> Vector2:
	var dir = v.normalized()

	# Garante componente vertical mínima
	if abs(dir.y) < min_vertical_ratio:
		dir.y = min_vertical_ratio * sign_nonzero(dir.y)

	# Reajusta X para continuar unitário
	dir.x = sign_nonzero(dir.x) * sqrt(max(0.0, 2.0 - dir.y * dir.y))

	return dir.normalized()

func _physics_process(delta):

	var collision = move_and_collide(velocity * delta)

	if collision:
		#velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		hit_sound.play()
		if collider and collider.is_in_group("paddle"):
			speed = min(speed + speed_increment, max_speed)
			var camera = get_tree().get_first_node_in_group("main_camera")
			if camera:
				camera.shake(5.0)

		speed = speed + 20
		velocity = velocity.bounce(collision.get_normal()).normalized() * speed
		global_position += collision.get_normal() * 4.0		
		posicao = global_position
		
		if collider.name == "gol_enemy":
			gols_player = gols_player + 1
			atualizar_placar()
			hit_goal.play()
			checar_vitoria()
			reset_ball()
			
		if collider.name == "gol_player":
			gols_enemy = gols_enemy + 1
			atualizar_placar()
			hit_goal.play()
			checar_vitoria()
			reset_ball()
