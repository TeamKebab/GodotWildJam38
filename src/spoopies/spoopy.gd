tool
extends KinematicBody2D
class_name Spoopy

# warning-ignore:unused_signal
signal player_detected
# warning-ignore:unused_signal
signal appeared

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


var target: KinematicBody2D

onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var detector = $PlayerDetector
onready var state_machine = $StateMachine
onready var motion = $Motion
onready var hitbox = $HitBox
onready var animation_player = $AnimationPlayer

func _ready() -> void:
	_set_disabled(true)
	state_machine._change_state("Hidden")
	hitbox.connect("area_entered", self, "_on_player_touched")


func player_detected() -> void:
	emit_signal("player_detected")


func appear() -> void:
	emit_signal("appeared")
	
	
func light_on() -> void:
	emit_signal("lit")


func light_off() -> void:
	emit_signal("unlit")


func identify() -> void:
	print("Identified!")
	emit_signal("identified") 
	

func _on_player_touched(player_damage_box: Area2D) -> void:
	var player = player_damage_box.get_parent()
	player.scare()

