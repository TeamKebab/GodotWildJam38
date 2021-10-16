extends Node2D

export var drain_per_tick = 1

onready var light = $Light
onready var turn_on_sound = $TurnOnSound
onready var turn_off_sound = $TurnOffSound
onready var detection_area = $DetectionArea
onready var timer = $Timer

func _ready() -> void:
	detection_area.connect("body_entered", self, "_on_body_lit")
	detection_area.connect("body_exited", self, "_on_body_unlit")
	
	timer.connect("timeout", self, "_on_timer_timeout")
	Game.connect("battery_out", self, "_on_battery_out")
	
	light.enabled = Game.flashlight_on
	detection_area.enabled = Game.flashlight_on
	
	if !Game.flashlight_on:
		timer.paused = true


func _input(event):
	if event is InputEventMouseMotion:
		_point_to(event.position)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			_toggle()


func _point_to(point: Vector2) -> void:
	rotation = point.angle_to_point(get_global_transform_with_canvas().origin)


func _toggle() -> void:	
	_turn_on(!Game.flashlight_on)

	
func _turn_on(value: bool) -> void:
	if value and Game.battery == 0:
		turn_off_sound.play()
		return
	
	Game.flashlight_on = value
	
	light.enabled = Game.flashlight_on
	detection_area.enabled = Game.flashlight_on
	timer.paused =  !Game.flashlight_on
		
	if Game.flashlight_on:
		turn_on_sound.play()
	else:
		turn_off_sound.play()


func _on_body_lit(body: PhysicsBody2D) -> void:
	body.light_on()


func _on_body_unlit(body: PhysicsBody2D) -> void:
	body.light_off()


func _on_timer_timeout() -> void:
	Game.drain_battery(drain_per_tick)


func _on_battery_out() -> void:
	if light.enabled:
		_toggle()
