tool
extends KinematicBody2D

onready var sprite = $Sprite
onready var collision = $CollisionShape2D

func _ready() -> void:
	_set_disabled(true)


func _set_disabled(value: bool) -> void:
	if value:
		sprite.hide()
		collision.disabled = true
	else:
		sprite.show()
		collision.disabled = false


func _on_player_detected(body) -> void:
	_set_disabled(false)
