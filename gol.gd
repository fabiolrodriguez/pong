extends Node2D

@onready var ball = $ball2D
@onready var bg = $bg

var score_player = 0
var score_enemy = 0

func _ready():
	bg.volume_db = -10
	bg.play()

  
