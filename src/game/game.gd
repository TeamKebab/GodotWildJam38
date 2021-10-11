extends Node

signal player_lives_changed(lives)
signal player_dead()

signal battery_changed(battery)
signal battery_out()

enum Scene {
	Level_01,
	Level_02,
}

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

onready var scene_loader = $SceneLoader

func _ready() -> void:
	_set_player_lives(max_player_lives)
	battery = max_battery
	
	randomize()
	
	scene_loader.scenes = {
		Scene.Level_01 : "res://levels/game_levels/level_01.tscn",
		Scene.Level_02 : "res://levels/game_levels/level_02.tscn",
	}	


func drain_battery(drain: int) -> void:
	battery = max(0, battery - drain)
	
	emit_signal("battery_changed", battery)
	
	if battery == 0:
		emit_signal("battery_out")


func restart() -> void:
	_set_player_lives(max_player_lives)
	battery = max_battery
	go_to(Scene.Level_01)


func go_to(scene_id: int, startup_data = null) -> void:
	scene_loader.load_scene(scene_id, startup_data)
