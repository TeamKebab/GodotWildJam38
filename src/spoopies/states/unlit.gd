extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()

func enter() -> void:
	print("unlit!")
	spoopy.connect("lit", self, "_on_lit")

func exit() -> void:
	spoopy.disconnect("lit", self, "_on_lit")
	

func _on_lit() -> void:
	emit_signal("finished", "Lit")
