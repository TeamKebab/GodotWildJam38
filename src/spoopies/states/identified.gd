extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()
onready var eyes = [
	spoopy.find_node("LeftEye"), 
	spoopy.find_node("RightEye")
]

func enter() -> void:
	spoopy.identify()
	spoopy.animation_player.play("identified")

	for eye in eyes:
		eye.enabled = false
		
func update(delta: float) -> void:
	spoopy.motion.move(0, delta)
