extends KinematicBody2D


export var invulnerability_time: float = 3

onready var motion = $Motion
onready var scare_sound = $ScareSound
onready var damage_box = $DamageBox

	
func _physics_process(delta: float) -> void:
	motion.move(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), delta)
	
	if Input.is_action_just_pressed("ui_up"):
		motion.jump()
	

func scare() -> void:
	Game.player_lives -= 1
	scare_sound.play()
	
	_set_invulnerable(true)
	
	yield(get_tree().create_timer(invulnerability_time), "timeout")
	
	_set_invulnerable(false)


func _set_invulnerable(value: bool) -> void:
	damage_box.get_child(0).call_deferred("set_disabled", value)
