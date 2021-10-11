tool
extends Node


export var disable_night = false setget _set_disable_night
func _set_disable_night(value: bool) -> void:
	disable_night = value
	
	if bg != null:
		bg.enable_canvas_modulate = !disable_night
	
	if canvas_modulate != null:
		canvas_modulate.visible = !disable_night


onready var gui = find_node("GUI")
onready var bg = $ParallaxBackground
onready var canvas_modulate = $CanvasModulate


func _ready() -> void:
	gui.show()
	_set_disable_night(disable_night)
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.scancode == KEY_R:
		Game.restart()
