extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()

func enter() -> void:
	print("unlit!")	
	spoopy.animation_player.play("unlit")
	spoopy.hitbox.get_child(0).disabled = false
	spoopy.shadow.show()
	spoopy.connect("lit", self, "_on_lit")

func exit() -> void:
	spoopy.hitbox.get_child(0).disabled = true
	spoopy.disconnect("lit", self, "_on_lit")
	

func update(delta: float) -> void:
	var x = spoopy.target.position.x - spoopy.position.x
	spoopy.motion.move(x / abs(x), delta)


func _on_lit() -> void:
	emit_signal("finished", "Lit")
