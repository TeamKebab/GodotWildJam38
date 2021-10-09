extends KinematicBody2D

export var gravity: int = 1000
export var acceleration: int = 2000
export var friction: int = 3000

export var max_run_speed: float = 300
export var max_fall_speed: float = 1000
export var jump_speed: float = -800

var motion = Vector2.ZERO
var was_walking = false
var was_on_floor = false

onready var walk_sound = $WalkSound
onready var jump_sound = $JumpSound
onready var land_sound = $LandSound

func _physics_process(delta: float) -> void:
	_move(delta)
	
	if motion.x != 0 and is_on_floor():
		if !was_walking:
			was_walking = true
			walk_sound.play()
	else:
		was_walking = false
		walk_sound.stop()

	if is_on_floor():
		if !was_on_floor:
			land_sound.play()
			was_on_floor = true
	else:
		was_on_floor = false
		
func _move(delta):	
	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	
	
	if x == 0:
		motion = motion.move_toward(Vector2(0, motion.y), friction * delta)
	else:
		motion = motion.move_toward(Vector2(x * max_run_speed, motion.y), acceleration * delta)
	
	motion.y += gravity * delta
	
	motion = move_and_slide(motion, Vector2.UP)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):		
			motion.y = jump_speed
			jump_sound.play()
