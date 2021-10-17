extends "res://levels/level.gd"


func _ready() -> void:
	$Spoopy.connect("player_detected", self, "_on_spoopy_appearing", [$Spoopy])
	$Spoopy.connect("appeared", self, "_on_spoopy_appeared")

func _on_spoopy_appearing(spoopy: Spoopy) -> void:
	$ZoomInCamera.zoom_at(spoopy.global_position)
	
func _on_spoopy_appeared() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	$ZoomInCamera.reset()

