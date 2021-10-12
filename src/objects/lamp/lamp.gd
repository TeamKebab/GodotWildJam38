extends StaticBody2D

var enabled: bool = true setget _set_enabled
func _set_enabled(value: bool) -> void:
	enabled = value
	
	for light in lights:
		light.enabled = value
	for light_ball in light_balls:
		light_ball.visible = value
		
		
onready var lights = [
	$Light2D,
	$Light2D2
]

onready var light_balls = $Path2D.get_children()
onready var charging_area = $ChargingArea
onready var timer = $Timer

func _ready() -> void:
	timer.connect("timeout", self, "_on_timeout")
	_set_enabled(false)


func _on_timeout() -> void:
	if enabled:
		if !charging_area.bodies_in_detection_area.empty():
			Game.charge_battery(1)


func light_on() -> void:
	_set_enabled(true)


func light_off() -> void:
	print("lamp unlit")
