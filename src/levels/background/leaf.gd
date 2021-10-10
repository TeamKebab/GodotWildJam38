tool
extends Sprite

const num_leaves = 2

func _ready():
	frame = randi() % num_leaves
	rotation = randf() * 2 * PI
	z_index = randi() % 5
	modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), 0.1) 

