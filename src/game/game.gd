extends Node

signal player_lives_changed(lives)

signal battery_changed(battery)
signal battery_out()

enum Scene {
	Level_01,
	Level_02,
	Start,
	GameOver,
	Win,
	Tutorial,
}

const main_score = preload("res://game/UNSPOOPIED_SUITE.mp3")

var player_lives: int setget _set_player_lives
func _set_player_lives(value: int) -> void:
	if value == player_lives:
		return
	player_lives = value
	emit_signal("player_lives_changed", player_lives)
	
var max_player_lives: int = 3

var battery: int  
var max_battery: int = 200

var identified_spoopies = 0
var max_spoopies = -1
var lit_lamps = 0
var max_lamps = 0
var player: KinematicBody2D
var player_camera: Camera2D
var flashlight_on = true

onready var scene_loader = $SceneLoader

func _ready() -> void:
	_set_player_lives(max_player_lives)
	battery = max_battery
	emit_signal("battery_changed", battery)
	
	randomize()
	
	scene_loader.scenes = {
		Scene.Level_01 : "res://levels/game_levels/level_01.tscn",
		Scene.Level_02 : "res://levels/game_levels/level_02.tscn",
		Scene.Start: "res://levels/start_screen/start_screen.tscn",
		Scene.GameOver: "res://levels/game_over/game_over.tscn",
		Scene.Win: "res://levels/win_screen/win_screen.tscn",
		Scene.Tutorial: "res://levels/tutorial/tutorial.tscn" ,
	}	
	play_music(main_score)

func drain_battery(drain: int) -> void:
	battery = int(max(0, battery - drain))
	
	emit_signal("battery_changed", battery)
	
	if battery == 0:
		emit_signal("battery_out")

func charge_battery(charge: int) -> void:
	battery = int(min(max_battery, battery + charge))
	
	emit_signal("battery_changed", battery)
	
	
func restart() -> void:
	_set_player_lives(max_player_lives)
	battery = max_battery
	identified_spoopies = 0
	lit_lamps = 0
	max_spoopies = -1
	max_lamps = 0
	flashlight_on = true
	
	play_music(main_score)
	go_to(Scene.Start)


func game_over() -> void:
	go_to(Scene.GameOver)
	

func play_music(stream: AudioStream) -> void:
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()
	
	
func go_to(scene_id: int, startup_data = null) -> void:
	scene_loader.load_scene(scene_id, startup_data)
