extends Node2D

var npc_animation_interval = 0.5
var npc_list = []


signal refresh_npc_animation
# Called when the node enters the scene tree for the first time.
func _ready():
	_init_global_timer()
	

func _process(delta):
	pass
	


# Global init area
func _init_global_timer():
	var timer = Timer.new()
	timer.wait_time = npc_animation_interval
	timer.autostart = true
	timer.connect("timeout", self, "_refresh_npc_animation")
	add_child(timer)




# Singal Process Area
func _refresh_npc_animation():
	self.emit_signal("refresh_npc_animation")

