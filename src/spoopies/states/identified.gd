extends "res://spoopies/states/walking.gd"

onready var eyes = [
	spoopy.find_node("LeftEye"), 
	spoopy.find_node("RightEye")
]
onready var animationStatus = animationTree.get("parameters/status/playback")

func enter() -> void:
	spoopy.identify()
	animationStatus.travel("identified")
	face(0)
	
	for eye in eyes:
		eye.enabled = false
		
func update(delta: float) -> void:
	spoopy.motion.move(0, delta)
