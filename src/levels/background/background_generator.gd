tool
extends Node2D

const leaf_spritesheet = preload("res://levels/background/leaves.png")
const num_sprites = 2

export var size: Vector2 = Vector2(1024, 600) setget _set_size
func _set_size(value:Vector2) -> void:
	size = value
	update()


export var density: int = 100 setget _set_density
func _set_density(value:int) -> void:
	density = value
	update()


func _draw() -> void:
#	get_viewport().transparent_bg = true
	var positions = []
	
	for x in size.x / density:
		for y  in size.y / density:
			positions.append(Vector2(x,y) * density + Vector2(_random_offset(), _random_offset()))

	positions.shuffle()
	
	for leaf_position in positions:
		_draw_leaf(leaf_position)
	
	_save_image()

func _random_offset() -> float:
	return rand_range(-density / 3, density / 3)


func _draw_leaf(leaf_position: Vector2) -> void:
	var size = Vector2(64, 64)
	var src_position = Vector2.RIGHT * (randi() % num_sprites)
	var modulate_color = Color(rand_range(0.7, 1), rand_range(0.7, 1), 0.1) 
	
	draw_set_transform(leaf_position + size / 2, randf() * 2 * PI, Vector2.ONE)
	
	draw_texture_rect_region(
		leaf_spritesheet, 
		Rect2(-size/2, size), 
		Rect2(src_position, size), 
		modulate_color)


func _save_image():
	var image = get_viewport().get_texture().get_data()
	image.convert(Image.FORMAT_RGBA8)
	image.save_png("res://levels/background/image.png")
