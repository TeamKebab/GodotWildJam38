tool
extends Node2D

signal object_detected(collider)


export var number_of_rays: int = 8 setget _set_number_of_rays
func _set_number_of_rays(value: int) -> void:
	if number_of_rays == value:
		return
	number_of_rays = value
	
	for ray in get_children():
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


var rays = []


func _ready():
	if rays.empty():
		_set_number_of_rays(number_of_rays)


func _physics_process(delta: float) -> void:
	for ray in rays:
		var collider = ray.get_collider()
		
		if collider == null:
			continue
		
		var collider_layer = collider.collision_layer
		
		if collider_layer & detection_mask > 0:
			emit_signal("object_detected", collider)
		
func _add_ray(angle: float) -> void:
	var ray = RayCast2D.new()
	ray.rotation = angle
	ray.cast_to.y = cast_radius
	ray.collision_mask = collision_mask | detection_mask
	ray.collide_with_areas = true
	ray.collide_with_bodies = true
	ray.enabled = true
	
	rays.append(ray)
	add_child(ray)

	
