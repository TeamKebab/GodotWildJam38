extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()

func enter() -> void:
	spoopy.detector.connect("body_entered", self, "_on_player_detected")	
	spoopy.detector.enabled = true
	

func exit() -> void:
	spoopy.detector.enabled = false


func _on_player_detected(_player: KinematicBody2D) -> void:
	print("player detected!")
	emit_signal("finished", "Appearing")
