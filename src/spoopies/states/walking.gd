extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()
onready var animationTree = spoopy.find_node("AnimationTree")
onready var animationDirection = animationTree.get("parameters/move_facing/facing_direction/playback")
onready var animationMove = animationTree.get("parameters/move_facing/move/playback")

var previous_direction = 0

func direction() -> float:
	var x = spoopy.target.position.x - spoopy.position.x
	return x / abs(x)

func face(direction: float) -> void:
	if direction < 0:
		animationDirection.travel("face_left")
	elif direction > 0:
		animationDirection.travel("face_right")

	if direction == 0:
		animationMove.travel("idle")
	else:
		animationMove.travel("walk")
