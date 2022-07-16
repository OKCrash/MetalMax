extends KinematicBody2D

enum objType {
	NPC,
	BOSS,
}

var animation_frame = 0
export(objType) var type


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = animation_frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _on_World_refresh_npc_animation():
	$Sprite.frame = abs($Sprite.frame - 1)
