extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()

func enter() -> void:
	spoopy.identify()
	spoopy.animation_player.play("identified")
