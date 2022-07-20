extends Area2D

signal hit_enemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hitbox_area_entered(area):
	print("Hit a enemy : " + str(area))
	emit_signal("hit_enemy")
