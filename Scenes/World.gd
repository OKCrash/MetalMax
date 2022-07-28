extends Node2D

var npc_animation_interval = 0.5

onready var battle_scene = preload("res://Scenes/Battle.tscn").instance()
onready var scene_tree = get_tree()
onready var world = get_node("/root/World")
onready var player = Player


# Called when the node enters the scene tree for the first time.
func _ready():
#	world.add_child(player)
	player.position = Vector2(448, 160)
	Signal.connect("switch_scene", self, "_on_Player_encounter_battle")


### Singal Process Area
func _refresh_npc_animation():
	emit_signal("refresh_npc_animation")


func _on_World_tree_exiting():
	print("Main scene out!")


func _on_Player_encounter_battle():
	print('Start battle......')
	emit_signal("switch_scene", battle_scene)
	

	
