extends Node2D

var started = false

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	started = true
	yield(get_tree().create_timer(5), "timeout")
	Game.go_to(Game.Scene.Level_01)

func _input(event):
	if started and event is InputEventKey:
		Game.go_to(Game.Scene.Level_01)
