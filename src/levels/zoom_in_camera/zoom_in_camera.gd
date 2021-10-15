extends Camera2D


export var zoom_in_duration = 0.5
export var duration:float = 2
export var zoom_out_duration = 0.5
export var zoom_scale = 0.5

onready var tween = $Tween
onready var previous_camera: Camera2D


func reset() -> void:
	
	tween.interpolate_property(
		self, "global_position", global_position, Game.player_camera.global_position,
		zoom_out_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		self, "zoom", Vector2.ONE * zoom_scale, Vector2.ONE,
		zoom_out_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	Game.player.resume()	
	Game.player_camera.current = true


func zoom_at(point: Vector2) -> void:
	Game.player.pause()
	
	global_position = Game.player_camera.global_position
	current = true
	
	tween.interpolate_property(
		self, "global_position", global_position, point,
		zoom_in_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		self, "zoom", Vector2.ONE, Vector2.ONE * zoom_scale,
		zoom_in_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	
	tween.start()
	
