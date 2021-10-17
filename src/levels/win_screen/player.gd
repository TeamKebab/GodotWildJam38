extends KinematicBody2D

export var rotation_speed = 0.1
export var speed = 100

onready var motion = Vector2.ONE.rotated(PI / 2 + rand_range(-0.1, 0.1)) * speed

func _physics_process(delta):
	rotation += rotation_speed * delta
	
	var collision = move_and_collide(motion * delta)
	
	if collision:
		motion = collision.normal * speed
