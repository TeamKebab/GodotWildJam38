tool
extends Sprite

const num_leaves = 2

onready var tween = $Tween


func _ready():
	frame = randi() % num_leaves
	rotation = randf() * 2 * PI
	z_index = randi() % 5
	modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), 0.1) 


func rustle():
	var duration = 0.1
	var delay = 0
	var angle1 = rotation + rand_range(0.2,0.2) * PI
	var angle2 = rotation - rand_range(0.2,0.2) * PI
	
	tween.interpolate_property(
		self, "rotation", rotation, angle1,
		duration, Tween.TRANS_LINEAR, Tween.EASE_OUT,
		delay
	)
	tween.interpolate_property(
		self, "rotation", angle1, rotation,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + duration
	)
	tween.interpolate_property(
		self, "rotation", rotation, angle2,
		duration, Tween.TRANS_LINEAR, Tween.EASE_OUT,
		delay + 2 * duration
	)
	tween.interpolate_property(
		self, "rotation", angle2, rotation,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + 3 * duration
	)
	
	tween.start()
	yield(tween, "tween_all_completed")
	rustle()
	
