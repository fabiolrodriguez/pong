extends CharacterBody2D

@export var speed = 200
@export var posicao : Vector2

func _ready():
	velocity = Vector2(1,1).normalized() * speed

func _physics_process(delta):

	var collision = move_and_collide(velocity * delta)

	if collision:
		velocity = velocity.bounce(collision.get_normal())
		posicao = global_position
