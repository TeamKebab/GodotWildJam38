extends KinematicBody2D


onready var motion = $Motion

func _physics_process(delta: float) -> void:
	motion.move(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), delta)
	
	if Input.is_action_just_pressed("ui_up"):
		motion.jump()
	
