extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()

func enter() -> void:
	print("something lurks in the shadows...")
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("finished", "Unlit")
	
func exit() -> void:
	spoopy._set_disabled(false)
