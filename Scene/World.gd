extends Node2D

var npc_animation_interval = 3

onready var battle_scene = preload("res://Scene/Battle.tscn").instance()
onready var scene_tree = get_tree()
onready var current_scene = scene_tree.current_scene


signal refresh_npc_animation
# Called when the node enters the scene tree for the first time.
func _ready():
	_init_global_timer()

# Global init area
func _init_global_timer():
	var timer = Timer.new()
	timer.wait_time = npc_animation_interval
	timer.autostart = true
	timer.one_shot = true
	timer.connect("timeout", self, "_refresh_npc_animation")
	add_child(timer)


# Singal Process Area
func _refresh_npc_animation():
	emit_signal("refresh_npc_animation")
	change_scene()
	

#func _on_Player_encounter_battle():
#	print("Enter the battle......")
#	start_battle()


func change_scene():
	current_scene.queue_free()
	scene_tree.root.add_child(battle_scene)
	scene_tree.current_scene = battle_scene
	
#func start_battle():
##	add_child(battle_scene)
#	scene_tree.current_scene = battle_scene
#	scene_tree.change_scene_to(battle_scene)
##	var bs_tree = get_tree()
##	bs_tree.current_scene = bs_tree
	


func _on_World_tree_exiting():
	print("Main scene out!")
