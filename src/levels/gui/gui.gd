extends MarginContainer


onready var lives = find_node("Lives")
onready var battery: TextureProgress = find_node("Battery")


func _ready() -> void:
	Game.connect("player_lives_changed", self, "_on_player_lives_changed")
	lives.value = Game.player_lives
	
	Game.connect("battery_changed", self, "_on_battery_changed")
	battery.max_value = Game.max_battery
	battery.value = Game.max_battery


func _on_player_lives_changed(player_lives: int) -> void:
	lives.value = player_lives


func _on_battery_changed(battery_charge: int) -> void:
	battery.value = float(battery_charge) / Game.max_battery * (173-12) + 12
