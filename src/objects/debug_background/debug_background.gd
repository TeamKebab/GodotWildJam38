extends Node2D

export var center_parent = true

export var size = Vector2(200, 200)

onready var bg: ColorRect = $Background


func _ready() -> void:
	bg.rect_size = size
	bg.rect_position = - size / 2
	
	if center_parent:
		get_parent().position = get_viewport().size / 2
