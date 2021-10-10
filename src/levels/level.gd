extends Node


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.scancode == KEY_R:
		Game.player_lives = Game.max_player_lives
		get_tree().reload_current_scene()
