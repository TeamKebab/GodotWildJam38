extends "res://spoopies/states/walking.gd"

onready var animationStatus = animationTree.get("parameters/status/playback")

func enter() -> void:
	print("unlit!")	
	
	spoopy.hitbox.get_child(0).disabled = false
	spoopy.shadow.show()
	spoopy.connect("lit", self, "_on_lit")

func exit() -> void:
	spoopy.hitbox.get_child(0).disabled = true
	spoopy.disconnect("lit", self, "_on_lit")
	

func update(delta: float) -> void:
	var facing_direction = direction()
	face(facing_direction)
	
	spoopy.motion.move(facing_direction, delta)


func _on_lit() -> void:
	emit_signal("finished", "Lit")
