extends Node

signal player_lives_changed(lives)
signal player_dead()

var player_lives: int setget _set_player_lives
func _set_player_lives(value: int) -> void:
	if value == player_lives:
		return
	player_lives = value
	emit_signal("player_lives_changed", player_lives)
	
	if player_lives <= 0:
		emit_signal("player_dead")
		restart()
		

var max_player_lives: int = 3


func _ready() -> void:
	_set_player_lives(max_player_lives)


func restart() -> void:
	_set_player_lives(max_player_lives)
	get_tree().reload_current_scene()
