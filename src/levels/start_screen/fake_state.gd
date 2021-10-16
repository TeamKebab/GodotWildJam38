extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()
onready var eyes = [
	spoopy.find_node("LeftEye"), 
	spoopy.find_node("RightEye")
]
onready var sprite = spoopy.find_node("Sprite")
onready var shadow = spoopy.find_node("LightOccluder2D")
onready var tree = spoopy.find_node("AnimationTree")
onready var animationStatus = tree.get("parameters/status/playback")

var started = false

	
func update(_delta:float) -> void:
	if started:
		return

	for eye in eyes:
		eye.show()
	
	spoopy._set_disabled(false)
	
	started = true
