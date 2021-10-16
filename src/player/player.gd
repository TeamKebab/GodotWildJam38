extends KinematicBody2D


export var invulnerability_time: float = 3

onready var motion = $Motion
onready var scare_sound = $ScareSound
onready var damage_box = $DamageBox

onready var animationTree = $AnimationTree
onready var facing_direction_animation = animationTree.get("parameters/facing_direction/playback")
onready var action_animation = animationTree.get("parameters/action/playback")


func _ready() -> void:
	Game.player = self
	Game.player_camera = $Camera2D
	
	animationTree.active = true
	
	
func _physics_process(delta: float) -> void:
	var input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.move(input, delta)
	
	if input < 0:
		facing_direction_animation.travel("face_left")
	elif input > 0:
		facing_direction_animation.travel("face_right")
	
	if motion.motion.y > 0:
		action_animation.travel("fall")
	elif motion.motion.y == 0 and motion.motion.x != 0:
		action_animation.travel("walk")
	else:
		action_animation.travel("idle")
		
	if Input.is_action_just_pressed("ui_up"):
		motion.jump()
	

func scare() -> void:
	Game.player_lives -= 1
	scare_sound.play()
	
	_set_invulnerable(true)
	
	yield(get_tree().create_timer(invulnerability_time), "timeout")
	
	_set_invulnerable(false)


func pause() -> void:
	set_physics_process(false)
	motion.stop_sound()
	
	
func resume() -> void:
	set_physics_process(true)


func _set_invulnerable(value: bool) -> void:
	damage_box.get_child(0).call_deferred("set_disabled", value)
