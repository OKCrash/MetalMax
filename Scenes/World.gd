extends Node2D

var npc_animation_interval = 0.5


onready var scene_tree = get_tree()
onready var level_scene = preload("res://Level/Level_1.tscn").instance()
onready var start_position = Vector2(32*10, 32*6)
onready var player  = preload("res://Characters/Player.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(level_scene)
	add_child(player)
	player.position = start_position
	player.connect("encounter_battle", self, "_on_Player_encounter_battle")


### Singal Process Area
func _refresh_npc_animation():
	emit_signal("refresh_npc_animation")


func _on_World_tree_exiting():
	print("Main scene free!")


func _on_Player_encounter_battle():
	print('Start battle......')
	var enemy_list = []
	var enemy = preload("res://Characters/Battle_Enemy.tscn").instance()
	for i in range(3):
		enemy_list.append(enemy.duplicate())
	set_process(false)
	Signal.emit_signal("switch_battle_scene", enemy_list)
#	scene_tree.current_scene.queue_free()
	
	
	

	
