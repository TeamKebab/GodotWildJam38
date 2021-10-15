extends "res://spoopies/states/walking.gd"

export var time_to_identify: float = 3

var lit_seconds = 0


func enter() -> void:
	print("lit!")
	lit_seconds = 0
	spoopy.connect("unlit", self, "_on_unlit")


func exit() -> void:
	spoopy.disconnect("unlit", self, "_on_unlit")


func update(delta: float) -> void:
	var facing_direction = direction()
	face(facing_direction)
	spoopy.motion.move(facing_direction * 0.2, delta)
	
	lit_seconds += delta
	
	if lit_seconds > time_to_identify:
		emit_signal("finished", "Identified")


func _on_unlit() -> void:
	emit_signal("finished", "Unlit")
