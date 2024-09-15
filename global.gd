extends Node

var SCORE : int = 0
var HEALTH : int = 3
var c_scene = null

## SCENE STUFFS!!
func _ready() -> void:
	var root := get_tree().root
	c_scene = root.get_child(root.get_child_count() - 1)


func switch_scene(packed_scene) -> void:
	call_deferred("_df_switch_scene", packed_scene)


func add_scene(scene : String):
	var root = get_tree().root
	var _scene = load(scene).instantiate()
	root.add_child(_scene)
	return _scene


func _df_switch_scene(packed_scene) -> void:
	c_scene.free()
	var s := load(packed_scene)
	c_scene = s.instantiate()
	#Tree Stuffs!
	var tree := get_tree()
	tree.root.add_child(c_scene)
	tree.current_scene = c_scene
## END OF SECTION

#func _process(delta):
	#pass
