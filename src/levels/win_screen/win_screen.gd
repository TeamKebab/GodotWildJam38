extends Node2D


const music = preload("res://levels/win_screen/win.ogg")

var started = false

func _ready():
	Game.play_music(music)
	
	$LampsCounter.value = Game.lit_lamps
	$LampsMax.value = Game.max_lamps
	$SpoopyCounter.value = Game.identified_spoopies
	$SpoopyMax.value = Game.max_spoopies
	
	yield(get_tree().create_timer(1), "timeout")
	started = true

func _input(event):
	if started and event is InputEventKey:
		Game.restart()
