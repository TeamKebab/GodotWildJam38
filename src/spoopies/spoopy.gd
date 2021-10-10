tool
extends KinematicBody2D
class_name Spoopy

signal lit
signal unlit
signal identified


var disabled setget _set_disabled
func _set_disabled(value: bool) -> void:
	if value:
		sprite.hide()
		collision.disabled = true
	else:
		sprite.show()
		collision.disabled = false


onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var detector = $PlayerDetector
onready var state_machine = $StateMachine

func _ready() -> void:
	_set_disabled(true)
	state_machine._change_state("Hidden")


func light_on() -> void:
	emit_signal("lit")


func light_off() -> void:
	emit_signal("unlit")


func identify() -> void:
	print("Identified!")
	emit_signal("identified") 
	



