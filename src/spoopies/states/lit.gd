extends "res://components/state_machine/state.gd"

export var time_to_identify: float = 3

var lit_seconds = 0

onready var spoopy = get_parent().get_parent()

func enter() -> void:
	print("lit!")
	spoopy.animation_player.play("unidentified")
	lit_seconds = 0
	spoopy.connect("unlit", self, "_on_unlit")


func exit() -> void:
	spoopy.disconnect("unlit", self, "_on_unlit")


func update(delta: float) -> void:
	var x = spoopy.target.position.x - spoopy.position.x
	spoopy.motion.move(x / abs(x) * 0.2, delta)
	
	lit_seconds += delta
	
	if lit_seconds > time_to_identify:
		emit_signal("finished", "Identified")


func _on_unlit() -> void:
	emit_signal("finished", "Unlit")
