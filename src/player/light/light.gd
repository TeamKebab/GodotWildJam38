extends Node2D

onready var light = $Light
onready var turn_on_sound = $TurnOnSound
onready var turn_off_sound = $TurnOffSound
onready var detection_area = $DetectionArea

func _ready() -> void:
	detection_area.connect("body_entered", self, "_on_spoopy_entered")
	detection_area.connect("body_exited", self, "_on_spoopy_exited")


func _input(event):
	if event is InputEventMouseMotion:
		_point_to(event.position)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			_toggle()


func _point_to(point: Vector2) -> void:
	rotation = point.angle_to_point(get_global_transform_with_canvas().origin)


func _toggle() -> void:
	if light.enabled:
		turn_off_sound.play()
	else:
		turn_on_sound.play()
		
	light.enabled = !light.enabled
	detection_area.enabled = light.enabled


func _on_spoopy_entered(spoopy: Spoopy) -> void:
	spoopy.light_on()


func _on_spoopy_exited(spoopy: Spoopy) -> void:
	spoopy.light_off()
