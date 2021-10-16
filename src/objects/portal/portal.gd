extends StaticBody2D


export(Game.Scene) var scene = Game.Scene.Level_01

var open = false

onready var collision = $CollisionShape2D
onready var teleportArea = $TeleportArea
onready var animationPlayer = $AnimationPlayer
onready var chargingSound = $ChargingSound


func _ready() -> void:
	_set_portal_active(false)
	teleportArea.connect("area_entered", self, "_on_player_entered")

func light_on() -> void:
	animationPlayer.play("charging")
	chargingSound.play()

 
func light_off() -> void:
	if !open:
		animationPlayer.play("idle")
		chargingSound.stop()
	

func _set_portal_active(value: bool) -> void:
	open = value
	teleportArea.get_child(0).disabled = !value
	collision.disabled = value
		

func _on_charged() -> void:
	_set_portal_active(true)
	
	
func _on_player_entered(_player_damage_box: Area2D) -> void:
	Game.go_to(scene)
