tool
extends ParallaxBackground

export var tiles = Vector2.ONE setget _set_tiles
func _set_tiles(value: Vector2) -> void:
	tiles = value
	_regenerate()
	

export var canvas_modulate = Color.white setget _set_canvas_modulate
func _set_canvas_modulate(value: Color) -> void:
	canvas_modulate = value
	$CanvasModulate.color = canvas_modulate


export var enable_canvas_modulate = true setget _set_enable_canvas_modulate
func _set_enable_canvas_modulate(value: bool) -> void:
	enable_canvas_modulate = value
	if enable_canvas_modulate: 
		$CanvasModulate.show()
	else:
		$CanvasModulate.hide()
		
onready var backgrounds = [
	$ParallaxLayer/Background,
	$ParallaxLayer2/Background,
	$ParallaxLayer3/Background,
]

func _ready() -> void:
	_regenerate()
		
	
func _regenerate() -> void:
	if backgrounds == null:
		return
		
	for bg in backgrounds:
		bg.tiles = tiles
