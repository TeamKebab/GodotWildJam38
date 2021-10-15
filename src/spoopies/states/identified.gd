extends "res://spoopies/states/walking.gd"

onready var animationStatus = animationTree.get("parameters/status/playback")

func enter() -> void:
	spoopy.identify()
	animationStatus.travel("identified")
	face(0)
	
		
func update(delta: float) -> void:
	spoopy.motion.move(0, delta)
