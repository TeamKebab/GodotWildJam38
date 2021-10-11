extends Area2D


export(Game.Scene) var scene = Game.Scene.Level_01

func _ready() -> void:
	connect("area_entered", self, "_on_player_entered")


func _on_player_entered(player_damage_box: Area2D) -> void:
	Game.go_to(scene)
