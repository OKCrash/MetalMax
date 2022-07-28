extends KinematicBody2D

enum objType {
	NPC,
	BOSS,
	ENEMY,
}

var animation_frame = 0

export(objType) var type
export(bool) var encounter_battle


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = animation_frame

	
func _on_World_refresh_npc_animation():
	$Sprite.frame = abs($Sprite.frame - 1)


func _on_Hurtbox_area_entered(area):
	pass
