extends Node2D

onready var scene_tree = get_tree()
onready var world_scene = scene_tree.root.get_node("/root/World")
onready var battle_scene = Battle

func _ready():
	Signal.connect("switch_battle_scene", self, "_switch_battle_scene")
	Signal.connect("battle_finished", self, "_switch_back")
	

func _switch_battle_scene(enemys):
	print('Switch to next scene.')
	if enemys:
		var iter = 1
		for enemy in enemys:
			enemy.position = Vector2(64 + 32* iter, 32 )
			battle_scene.add_child(enemy)
			iter += 1
	scene_tree.root.remove_child(world_scene)
	scene_tree.root.add_child(battle_scene)
		
			

func _switch_back():
	print('Switch back to prev scene.')
	scene_tree.root.remove_child(battle_scene)
	scene_tree.root.add_child(world_scene)
	

func _level_tilemap_switch():
	pass
