tool
extends Node2D

const light_textures = [
	preload("res://levels/win_screen/numbers/light-0.png"),
	preload("res://levels/win_screen/numbers/light-1.png"),
	preload("res://levels/win_screen/numbers/light-2.png"),
	preload("res://levels/win_screen/numbers/light-3.png"),
	preload("res://levels/win_screen/numbers/light-4.png"),
	preload("res://levels/win_screen/numbers/light-5.png"),
	preload("res://levels/win_screen/numbers/light-6.png"),
	preload("res://levels/win_screen/numbers/light-7.png"),
	preload("res://levels/win_screen/numbers/light-8.png"),
	preload("res://levels/win_screen/numbers/light-9.png"),
]

export(int, 0, 9) var value = 0 setget _set_value
func _set_value(_value: int) -> void:
	value = _value
	
	$Sprite.frame = value
	$Light2D.texture = light_textures[value]


var size setget , _get_size
func _get_size() -> Vector2:
	return $Sprite.get_rect().size
