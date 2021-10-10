extends Node

signal player_lives_changed(lives)
signal player_dead()

signal battery_changed(battery)
signal battery_out()

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

var battery: int  
var max_battery: int = 30

func _ready() -> void:
	_set_player_lives(max_player_lives)
	battery = max_battery
	
	randomize()

func drain_battery(drain: int) -> void:
	battery = max(0, battery - drain)
	
	emit_signal("battery_changed", battery)
	
	if battery == 0:
		emit_signal("battery_out")


func restart() -> void:
	_set_player_lives(max_player_lives)
	battery = max_battery
	get_tree().reload_current_scene()
