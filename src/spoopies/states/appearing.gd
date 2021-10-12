extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()
onready var rustling = spoopy.find_node("Rustling")

func enter() -> void:
	print("something lurks in the shadows...")
	rustling.show()
	rustling.start()
	yield(rustling, "sound_finished")
	emit_signal("finished", "Unlit")
	
func exit() -> void:
	rustling.queue_free()
	
	spoopy._set_disabled(false)
