extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $Timer
export(int) var l_velocity = 200

func _ready():
#	mass = 3
	timer.wait_time = 5
	add_child(timer)
	

func _on_Timer_timeout():
	apply_impulse(Vector2.ZERO, Vector2.UP * l_velocity)
#	applied_force = Vector2.UP * l_velocity
	print(linear_velocity)
