tool
extends Area2D

export var texture: Texture setget _set_texture
func _set_texture(value: Texture) -> void:
	texture = value
	$Sprite.texture = texture
	$Sprite/Light2D.texture = texture


func _ready() -> void:
	$Timer.connect("timeout", self, "flicker")
	time_flicker()

func flicker() -> void:
	$AnimationPlayer.play("flicker")
	time_flicker()
	
	
func time_flicker() -> void:
	$Timer.start(rand_range(0.5, 1))
