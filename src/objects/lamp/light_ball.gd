extends PathFollow2D


export var speed = 0.05

var flickering = false 
onready var light = $Light
onready var sprite = $Sprite
onready var spotlight = $Sprite/Spotlight

onready var tween = $Tween


func _ready() -> void:	
	light.energy = 0
	spotlight.energy = 0
	sprite.modulate.a = 0
	
	if $DebugBG.visible:
		yield(get_tree().create_timer(3), "timeout")
		lit_up()

func _physics_process(delta: float) -> void:
	unit_offset += speed * delta
	

func lit_up() -> void:
	for i in 5:
		_flicker_on()
		yield(tween, "tween_all_completed")
		
		_flicker_off()
		yield(get_tree().create_timer(0.5 - i / 10.0), "timeout")
		
	_flicker_on()


func _flicker_on() -> void:
	var duration = rand_range(0.2, 0.6)
	var duration_offset = 0.1
	
	tween.interpolate_property(
		light, "energy", light.energy, 2,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		duration_offset
	)
	tween.interpolate_property(
		sprite, "modulate:a", sprite.modulate.a, 1,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		duration_offset
	)
	tween.interpolate_property(
		spotlight, "energy", spotlight.energy, 1,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		0
	)
	
	tween.start()


func _flicker_off() -> void: 
	var duration = 0.2
	var duration_offset = 0.1
	
	tween.interpolate_property(
		light, "energy", 2, 0,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		duration_offset
	)
	tween.interpolate_property(
		sprite, "modulate:a", 1, 0,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		duration_offset
	)
	tween.interpolate_property(
		spotlight, "energy", 1.5, 0, 
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		0
	)
	
	tween.start()
	

