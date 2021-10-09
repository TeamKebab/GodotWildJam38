tool
extends Node2D

signal body_entered(body)
signal body_exited(body)


export var number_of_rays: int = 16 setget _set_number_of_rays
func _set_number_of_rays(value: int) -> void:
	number_of_rays = value
	
	if (rays_container == null):
		return
	
	for ray in rays_container.get_children():
		rays.erase(ray)
		ray.queue_free()
		
	for i in number_of_rays:
		_add_ray(2*PI / number_of_rays * i)


export(int, LAYERS_2D_PHYSICS) var detection_mask setget _set_detection_mask
func _set_detection_mask(value: int) -> void:
	if detection_mask == value:
		return
	detection_mask = value
	
	for ray in rays:
		ray.collision_mask = collision_mask | detection_mask
	
	if detection_area == null:
		return
			
	_setup_detection_area()

export(int, LAYERS_2D_PHYSICS) var collision_mask setget _set_collision_mask
func _set_collision_mask(value: int) -> void:
	if collision_mask == value:
		return
	collision_mask = value
	
	for ray in rays:
		ray.collision_mask = collision_mask | detection_mask


export(int) var cast_radius setget _set_cast_radius
func _set_cast_radius(value: int) -> void:
	if cast_radius == value:
		return
	cast_radius = value
	
	for ray in rays:
		ray.cast_to.y = cast_radius
	
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

onready var rays_container = $Rays
onready var detection_area = $DetectionArea


func _ready():
	_setup_detection_area()
	if rays.empty():
		_set_number_of_rays(number_of_rays)


func _physics_process(delta: float) -> void:
	if Engine.editor_hint:
		return
	var bodies_still_in_detection_area = []
	var detected_bodies = detection_area.get_overlapping_bodies()
	
	if detected_bodies.empty():
		return
	
	for ray in rays:
		ray.force_raycast_update()
		var collider = ray.get_collider()
		
		if detected_bodies.has(collider):
			bodies_still_in_detection_area.append(collider)
			detected_bodies.erase(collider)
			
		if detected_bodies.empty():
			break
			
	for body in bodies_still_in_detection_area:
		if not bodies_in_detection_area.has(body):
			emit_signal("body_entered", body)
		bodies_in_detection_area.erase(body)
	
	for body in bodies_in_detection_area:
		emit_signal("body_exited", body)
	
	bodies_in_detection_area = bodies_still_in_detection_area


func _add_ray(angle: float) -> void:
	var ray = RayCast2D.new()
	ray.rotation = angle
	ray.cast_to.y = cast_radius
	ray.collision_mask = collision_mask | detection_mask
	ray.collide_with_areas = true
	ray.collide_with_bodies = true
	
	rays.append(ray)
	rays_container.add_child(ray)


func _setup_detection_area() -> void:
	var shape = CircleShape2D.new()
	shape.radius = cast_radius
	
	detection_area.get_child(0).set_shape(shape)
	detection_area.collision_mask = detection_mask
