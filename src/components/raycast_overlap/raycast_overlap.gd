tool
extends Node2D

signal body_entered(body)
signal body_exited(body)

export var half_angle: float = PI setget _set_half_angle
func _set_half_angle(value: float) -> void:
	half_angle = value
	_setup_rays()


export var number_of_rays: int = 16 setget _set_number_of_rays
func _set_number_of_rays(value: int) -> void:
	number_of_rays = value
	_setup_rays()


export(int, LAYERS_2D_PHYSICS) var detection_mask setget _set_detection_mask
func _set_detection_mask(value: int) -> void:
	if detection_mask == value:
		return
	detection_mask = value
		
	if detection_area == null:
		return
			
	_setup_detection_area()

export(int, LAYERS_2D_PHYSICS) var collision_mask

export(int) var cast_radius setget _set_cast_radius
func _set_cast_radius(value: int) -> void:
	if cast_radius == value:
		return
	cast_radius = value
	
	if detection_area == null:
		return
		
	_setup_detection_area()


export(bool) var enabled = true setget _set_enabled
func _set_enabled(value: bool) ->void:
	if detection_area == null:
		return
	enabled = value
	
	detection_area.get_child(0).disabled = !enabled

var rays = []
var bodies_in_detection_area = []

onready var detection_area = $DetectionArea


func _ready():
	_setup_detection_area()
	if rays.empty():
		_set_number_of_rays(number_of_rays)


func _physics_process(_delta: float) -> void:
	if Engine.editor_hint:
		return
		
	var bodies_still_in_detection_area = []
	var detected_bodies = detection_area.get_overlapping_bodies()
	
	var space_state = get_world_2d().direct_space_state
	var exceptions = []

	for ray_angle in rays:
		if detected_bodies.empty():
			break		
		
		var ray_target = Vector2(cast_radius, 0).rotated(global_rotation + ray_angle) + global_position
		var ray_mask = collision_mask | detection_mask
		
		var result = space_state.intersect_ray(
			global_position, 
			ray_target, 
			bodies_still_in_detection_area, 
			ray_mask)
		
		while !result.empty():
			if result.collider.collision_layer & collision_mask:
				break
			
			exceptions.append(result.collider)
			
			if detected_bodies.has(result.collider):
				bodies_still_in_detection_area.append(result.collider)
				detected_bodies.erase(result.collider)
			
			result = space_state.intersect_ray(
				global_position, 
				ray_target, 
				exceptions, 
				ray_mask)

	for body in bodies_still_in_detection_area:
		if not bodies_in_detection_area.has(body):
			emit_signal("body_entered", body)
		bodies_in_detection_area.erase(body)
	
	for body in bodies_in_detection_area:
		emit_signal("body_exited", body)
	
	bodies_in_detection_area = bodies_still_in_detection_area
	

func _setup_rays() -> void:	
	var is_arc = half_angle < PI
	var adjusted_number_of_rays = number_of_rays
	
	if is_arc:
		adjusted_number_of_rays = number_of_rays - 1
			
	for i in adjusted_number_of_rays:
		rays.append(2 * half_angle / adjusted_number_of_rays * i - half_angle)

	if is_arc:
		rays.append(half_angle)
	

func _setup_detection_area() -> void:
	var shape = CircleShape2D.new()
	shape.radius = cast_radius
	
	detection_area.get_child(0).set_shape(shape)
	detection_area.collision_mask = detection_mask
