extends Node


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.scancode == KEY_R:
		Game.restart()
