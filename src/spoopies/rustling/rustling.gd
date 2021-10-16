tool
extends Node2D

signal sound_finished

const Leaf = preload("res://levels/background/leaf.tscn")

export var radius = 200 setget _set_radius
func _set_radius(value:float) -> void:
	radius = value
	_regenerate()


export var density: int = 100 setget _set_density
func _set_density(value:int) -> void:
	density = value
	_regenerate()
	

onready var leaves_container = $Leaves
onready var rustling_sound = $RustlingSound


func _ready() -> void:
	_regenerate()


func start() -> void:
	rustling_sound.play()
	yield(rustling_sound, "finished")
	emit_signal("sound_finished")


func _regenerate() -> void:
	if leaves_container == null:
		return
		
	for leaf in leaves_container.get_children():
		leaf.queue_free()

	var layers = radius / density
	
	for r in layers:
		var layer_radius = density * r
		var circumference = 2 * PI * layer_radius
		var leaves = int(circumference / density)
		
		for a in leaves:
			var angle = a * 2 * PI / leaves
			var leaf_position = Vector2(layer_radius, 0).rotated(angle)
			_add_leaf(leaf_position)


func _add_leaf(leaf_position: Vector2) -> void:
	var random_offset = Vector2(randf() * density / 2, randf() * density / 2)
	var leaf = Leaf.instance()
	leaf.scale = Vector2(0.6,0.6)
	leaf.position = leaf_position + random_offset
	leaves_container.add_child(leaf)

	
