extends Node
class_name SceneLoader


signal scene_loaded(scene_id)


export(Dictionary) var scenes:= {}


var current_scene


func _ready():
	set_current_scene()
	
		
func set_current_scene():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
		
		
func load_scene(scene, data = null):
	assert(scenes.has(scene))
	
	call_deferred("_deferred_load_scene", scene, data)


func _deferred_load_scene(scene, data):
	var path = scenes[scene]
	
	current_scene.free()
		
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	if current_scene.has_method("set_data"):
		current_scene.set_data(data)
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	
	emit_signal("scene_loaded", scene)
