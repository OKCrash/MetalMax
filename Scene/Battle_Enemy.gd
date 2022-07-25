extends RigidBody2D

export(Vector2) var knockback = Vector2.RIGHT

func _physics_process(delta):
#	Keep roation zero
	rotation = 0
	
func _on_Hurtbox_area_entered(area):
	linear_velocity = knockback
	

func _on_EnemyStatus_status_death():
	print("Oops, I'm dead!")
	queue_free()
