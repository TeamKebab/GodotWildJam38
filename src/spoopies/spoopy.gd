tool
extends KinematicBody2D

onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var detector = $PlayerDetector

func _ready() -> void:
	_set_disabled(true)
	detector.connect("body_entered", self, "_on_player_detected")	


func _set_disabled(value: bool) -> void:
	if value:
		sprite.hide()
		collision.disabled = true
	else:
		sprite.show()
		collision.disabled = false


func _on_player_detected(body: Object) -> void:
	print("player detected!")
	detector.enabled = false
	_set_disabled(false)