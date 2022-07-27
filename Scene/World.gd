extends Node2D

var npc_animation_interval = 0.5

onready var battle_scene = preload("res://Scene/Battle.tscn").instance()
onready var scene_tree = get_tree()


signal refresh_npc_animation

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_global_timer()


# Global init area
func _init_global_timer():
	var timer = Timer.new()
	timer.wait_time = npc_animation_interval
	timer.autostart = true
	timer.connect("timeout", self, "_refresh_npc_animation")
	add_child(timer)


### Singal Process Area
func _refresh_npc_animation():
	emit_signal("refresh_npc_animation")


func _on_World_tree_exiting():
	print("Main scene out!")


func _on_Player_encounter_battle():
	scene_tree.current_scene.queue_free()
	scene_tree.root.add_child(battle_scene)
	

	
