extends Camera2D

@export var shake_decay: float = 8.0
@export var max_offset: float = 12.0

var shake_strength: float = 0.0

func _ready():
	randomize()

func _process(delta):
	if shake_strength > 0.0:
		shake_strength = lerp(shake_strength, 0.0, shake_decay * delta)
		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = Vector2.ZERO

func shake(amount: float):
	shake_strength = min(shake_strength + amount, max_offset)
