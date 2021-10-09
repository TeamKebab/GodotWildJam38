extends Light2D


func _input(event):
	if event is InputEventMouseMotion:
		_point_to(event.position)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			_toggle()

func _point_to(point: Vector2) -> void:
	rotation = point.angle_to_point(global_position)

func _toggle() -> void:
	enabled = !enabled