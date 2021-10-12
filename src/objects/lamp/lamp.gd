extends StaticBody2D

export var charge_per_tick: int = 1
export var start_lit = false

var enabled: bool = true setget _set_enabled
func _set_enabled(value: bool) -> void:
	enabled = value
	
	charging_area.enabled = value
	
	if not enabled:
		area_light.energy = 0
		bulb_light.energy = 0
		

onready var light_balls_container = $Path2D
onready var light_balls = light_balls_container.get_children()
onready var charging_area = $ChargingArea
onready var timer = $ChargingTimer
onready var animation_player = $AnimationPlayer
onready var charging_sound = $ChargingSound

onready var area_light = $AreaLight
onready var bulb_light = $BulbLight

func _ready() -> void:
	timer.connect("timeout", self, "_on_timeout")
	light_balls_container.visible = true

	var start_offset = randf()
	for i in light_balls.size():
		light_balls[i].unit_offset = start_offset + float(i) / light_balls.size()
		
	charging_area.connect("body_entered", self, "_on_player_charging")
	charging_area.connect("body_exited", self, "_on_player_not_charging")
	Game.connect("battery_changed", self, "_on_battery_changed")
	
	if start_lit:
		_set_enabled(true)
		area_light.energy = 0.8
		bulb_light.energy = 2
		for light in light_balls:
			light.lit_up()
	
	else:
		_set_enabled(false)


func _on_timeout() -> void:
	if enabled:
		if !charging_area.bodies_in_detection_area.empty():
			Game.charge_battery(charge_per_tick)


func _on_player_charging(_player: KinematicBody2D) -> void:
	if Game.battery < Game.max_battery:
		charging_sound.play()

func _on_battery_changed(battery: float) -> void:
	if Game.battery >= Game.max_battery:
		charging_sound.stop()

func _on_player_not_charging(_player: KinematicBody2D) -> void:
	charging_sound.stop()
	
func _input(event: InputEvent) -> void:
	if $DebugBG.visible:
		if event is InputEventMouseButton:
			if  event.pressed:
				if enabled:
					_set_enabled(false)
					for light_ball in light_balls:
						light_ball.lit_down()
				else:
					light_on()
			else:
				light_off()

			
func light_on() -> void:
	if enabled:
		return
	
	animation_player.play("lit_up")
	for light_ball in light_balls:
		light_ball.lit_up()


func light_off() -> void:
	if enabled: 
		return
	
	animation_player.stop()
	
	for light_ball in light_balls:
		light_ball.lit_down()
		
	area_light.energy = 0
	bulb_light.energy = 0
