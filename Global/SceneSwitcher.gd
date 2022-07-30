extends Node2D

export(PackedScene) var prev_scene
export(PackedScene) var next_scene

onready var scene_tree = get_tree()
onready var current_scene = scene_tree.current_scene
onready var battle_scene = preload("res://Scenes/Battle.tscn").instance()

func _ready():
	Signal.connect("switch_battle_scene", self, "_switch_battle_scene")
	

func _switch_battle_scene(enemys):
	print('Switch to next scene.')
	if enemys:
		var iter = 1
		for enemy in enemys:
			enemy.position = Vector2(64 + 32* iter, 32 )
			battle_scene.add_child(enemy)
			iter += 1
	if next_scene:		
		scene_tree.root.add_child(battle_scene)
	else:
		print("Cant switch to next scene.")
		

func _switch_back(prev_scene):
	print('Switch back to prev scene.')
	if prev_scene:
		call_deferred(scene_tree.current_scene.queue_free())
		scene_tree.change_scene_to(prev_scene)
