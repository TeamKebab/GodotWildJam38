extends "res://components/state_machine/state.gd"

onready var spoopy = get_parent().get_parent()
onready var detector = spoopy.find_node("PlayerDetector")

func enter() -> void:
	detector.connect("body_entered", self, "_on_player_detected")	
	detector.enabled = true
	

func exit() -> void:
	detector.enabled = false


func _on_player_detected(player: KinematicBody2D) -> void:
	spoopy.emit_signal("player_detected")
	spoopy.target = player
	emit_signal("finished", "Appearing")
