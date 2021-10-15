extends Node2D

export var gravity: int = 1000
export var acceleration: int = 2000
export var friction: int = 3000

export var max_run_speed: float = 300
export var max_fall_speed: float = 1000
export var jump_speed: float = -800

export var walk_stream: AudioStream
export var jump_stream: AudioStream
export var land_stream: AudioStream

var motion = Vector2.ZERO
var was_walking = false
var was_on_floor = false

var walk_sound: AudioStreamPlayer2D
var jump_sound: AudioStreamPlayer2D
var land_sound: AudioStreamPlayer2D

onready var body: KinematicBody2D = get_parent()


func _ready() -> void:
	if walk_stream != null:
		walk_sound = $WalkSound
		walk_sound.stream = walk_stream
		
	if jump_stream != null:
		jump_sound = $JumpSound
		jump_sound.stream = jump_stream
		
	if land_stream != null:
		land_sound = $LandSound
		land_sound.stream = land_stream
		

func stop_sound() -> void:
	if walk_sound != null:
		walk_sound.stop()

func move(input_x: float, delta: float) -> void:
	if input_x == 0:
		motion = motion.move_toward(Vector2(0, motion.y), friction * delta)
	else:
		motion = motion.move_toward(Vector2(input_x * max_run_speed, motion.y), acceleration * delta)
	
	motion.y += gravity * delta
	
	motion = body.move_and_slide(motion, Vector2.UP)
	
	if motion.x != 0 and body.is_on_floor():
		if !was_walking:
			was_walking = true
			if walk_sound != null:
				walk_sound.play()
	else:
		was_walking = false
		if walk_sound != null:
			walk_sound.stop()

	if body.is_on_floor():
		if !was_on_floor:
			if land_sound != null:
				land_sound.play()
			was_on_floor = true
	else:
		was_on_floor = false


func jump() -> void:
	if body.is_on_floor():
		motion.y = jump_speed
		if jump_sound != null:
			jump_sound.play()
