extends Node

signal player_lives_changed(lives)
signal player_dead()

var player_lives: int setget _set_player_lives
func _set_player_lives(value: int) -> void:
	if value == player_lives:
		return
	player_lives = value
	emit_signal("player_lives_changed", player_lives)


var max_player_lives: int = 5


func _ready() -> void:
	_set_player_lives(max_player_lives)
