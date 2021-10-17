tool
extends Node2D

const Digit = preload("res://levels/win_screen/numbers/digit.tscn")

export(int, 1, 9) var digits = 1 setget _set_digits
func _set_digits(_digits: int) -> void:
	digits = _digits
	max_value = int(pow(10, digits) - 1)
	
	for child in digit_list:
		remove_child(child)
		child.queue_free()
		
	var offset = Vector2.ZERO
	
	digit_list = []	
	for d in digits:
		var digit = Digit.instance()
		digit.position = offset
		offset += Vector2(digit.size.x, 0)
		digit_list.append(digit)
		add_child(digit)
	
	_set_value(value)


export(int, 0, 999999999) var value = 1 setget _set_value
func _set_value(_value: int) -> void:
	if _value > max_value:
		value = max_value
	else:
		value = _value
	
	if digit_list.empty():
		return
	
	var rest = value
	for d in digits:
		var digit = digit_list[d]
		var digit_factor = int(pow(10, digits - d - 1))
		var v = rest / digit_factor
		rest = rest % digit_factor
		
		digit.value = v

var max_value: int = 9
var digit_list = []


func _ready() -> void:
	_set_digits(digits)
