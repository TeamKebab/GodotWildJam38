extends PathFollow2D


export var speed = 0.05

func _physics_process(delta: float) -> void:
	unit_offset += speed * delta

func turn_on(value: bool) -> void:
	$Light2D2.enabled = value
	$Sprite/Light2D.enabled = value
