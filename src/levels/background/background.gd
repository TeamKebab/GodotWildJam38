tool
extends Node2D


const sprite_texture = preload("res://levels/background/many_leaves2.png")

export var tiles = Vector2.ONE setget _set_tiles
func _set_tiles(value: Vector2) -> void:
	tiles = value
	_regenerate()
	
export var offset = Vector2.ZERO setget _set_offset
func _set_offset(value: Vector2) -> void:
	offset = value
	_regenerate()
	
func _ready() -> void:
	_regenerate()
	
func _regenerate() -> void:
	for child in get_children():
		child.queue_free()
	
	for x in tiles.x:
		for y in tiles.y:
			var sprite = Sprite.new()
			sprite.texture = sprite_texture
			var sprite_size = sprite_texture.get_size() + offset
			sprite.position = Vector2(x * sprite_size.x, y * sprite_size.y) + sprite_size / 2
						
			add_child(sprite)
