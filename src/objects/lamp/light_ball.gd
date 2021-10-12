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
		_debug_animation()

func _physics_process(delta: float) -> void:
	unit_offset += speed * delta
	

func lit_up() -> void:
	_create_lit_up_tween()
	tween.start()


func lit_down() -> void:
	tween.remove_all()
	light.energy = 0
	spotlight.energy = 0
	sprite.modulate.a = 0
	

func _create_lit_up_tween() -> void:
	var total_duration = 0
	
	for i in 3:
		var lit_up_duration = rand_range(0.1, 0.4)
		var lit_down_duration = 0.2
		var off_duration = 0.3 - i / 10.0
		
		_add_light_on_tween(lit_up_duration, total_duration)
		total_duration += lit_up_duration
		_add_light_off_tween(lit_down_duration, total_duration)		
		total_duration += lit_down_duration + off_duration
		
	_add_light_on_tween(rand_range(0.2, 0.6), total_duration)	


func _add_light_on_tween(duration: float, delay: float) -> void:
	var duration_offset = 0.1
	
	tween.interpolate_property(
		light, "energy", light.energy, 2,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + duration_offset
	)
	tween.interpolate_property(
		sprite, "modulate:a", sprite.modulate.a, 1,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + duration_offset
	)
	tween.interpolate_property(
		spotlight, "energy", spotlight.energy, 1,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + 0
	)


func _add_light_off_tween(duration: float, delay: float) -> void: 
	var duration_offset = 0.1
	
	tween.interpolate_property(
		light, "energy", 2, 0,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + duration_offset
	)
	tween.interpolate_property(
		sprite, "modulate:a", 1, 0,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + duration_offset
	)
	tween.interpolate_property(
		spotlight, "energy", 1.5, 0, 
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN,
		delay + 0
	)


func _debug_animation() -> void:
	yield(get_tree().create_timer(3), "timeout")
	lit_up()
	yield(get_tree().create_timer(2), "timeout")
	lit_down()	
	_debug_animation()

