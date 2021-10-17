extends "res://spoopies/states/walking.gd"

onready var animationStatus = animationTree.get("parameters/status/playback")

func enter() -> void:
	Game.identified_spoopies += 1
	spoopy.identify()
	animationStatus.travel("identified")
	face(0)
	
		
func update(delta: float) -> void:
	spoopy.motion.move(0, delta)
