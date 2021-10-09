extends Light2D


onready var turn_on_sound = $TurnOnSound
onready var turn_off_sound = $TurnOffSound


func _input(event):
	if event is InputEventMouseMotion:
		_point_to(event.position)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			_toggle()


func _point_to(point: Vector2) -> void:
	rotation = point.angle_to_point(get_global_transform_with_canvas().origin)


func _toggle() -> void:
	if enabled:
		turn_off_sound.play()
	else:
		turn_on_sound.play()
		
	enabled = !enabled
