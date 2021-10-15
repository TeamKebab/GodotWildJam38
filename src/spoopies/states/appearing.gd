extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()
onready var rustling = spoopy.find_node("Rustling")
onready var eyes = [
	spoopy.find_node("LeftEye"), 
	spoopy.find_node("RightEye")
]

func enter() -> void:
	print("something lurks in the shadows...")
	rustling.show()
	rustling.start()
	yield(rustling, "sound_finished")
	emit_signal("finished", "Unlit")
	
	for eye in eyes:
		eye.show()
		
func exit() -> void:
	rustling.queue_free()
	spoopy.emit_signal("appeared")
	spoopy._set_disabled(false)
