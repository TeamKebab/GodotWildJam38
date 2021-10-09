extends KinematicBody2D

export var gravity: int = 1000
export var acceleration: int = 2000
export var friction: int = 3000

export var max_run_speed: float = 300
export var max_fall_speed: float = 1000
export var jump_speed: float = -800

var motion = Vector2.ZERO


func _physics_process(delta: float) -> void:
	_move(delta)
	

func _move(delta):	
	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	
	
	if x == 0:
		motion = motion.move_toward(Vector2(0, motion.y), friction * delta)
	else:
		motion = motion.move_toward(Vector2(x * max_run_speed, motion.y), acceleration * delta)
	
	motion.y += gravity * delta
	
	motion = move_and_slide(motion, Vector2.UP)
	
	if Input.is_action_just_pressed("ui_up"):		
		if is_on_floor():
			motion.y = jump_speed
	
