extends "res://spoopies/states/walking.gd"

const sounds = [
	preload("res://spoopies/spoopy_unspoopied.wav"),
	preload("res://spoopies/spoopy_unspoopied2.wav"),
	preload("res://spoopies/spoopy_unspoopied4.wav"),
	preload("res://spoopies/spoopy_unspoopied5.wav"),
]

onready var animationStatus = animationTree.get("parameters/status/playback")
onready var sound = spoopy.find_node("AudioStreamPlayer2D")


func enter() -> void:
	Game.identified_spoopies += 1
	sound.stream = sounds[randi() % sounds.size()]
	sound.play()
	spoopy.identify()
	animationStatus.travel("identified")
	face(0)
	
		
func update(delta: float) -> void:
	spoopy.motion.move(0, delta)
