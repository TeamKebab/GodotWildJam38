extends CanvasLayer


onready var lives = find_node("Lives")


func _ready() -> void:
	Game.connect("player_lives_changed", self, "_on_player_lives_changed")
	lives.value = Game.player_lives


func _on_player_lives_changed(player_lives: int) -> void:
	lives.value = player_lives
