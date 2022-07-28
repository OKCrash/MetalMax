extends Node2D

export(PackedScene) var prev_scene
export(PackedScene) var next_scene

onready var scene_tree = get_tree()


func _switch_scene(next_scene):
	if next_scene:
		prev_scene = scene_tree.current_scene
		yield(call_deferred(scene_tree.current_scene.queue_free()), "finished")
		scene_tree.change_scene_to(next_scene)
	else:
		print("Cant switch to next scene.")
		

func _switch_back(prev_scene):
	if prev_scene:
		yield(call_deferred(scene_tree.current_scene.queue_free()), "finished")
		scene_tree.change_scene_to(prev_scene)
