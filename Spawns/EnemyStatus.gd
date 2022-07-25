extends  Status

func _on_Hurtbox_area_entered(area):
	if area.hit_data:
		var damage = area.hit_data
		HP -= damage["STR"]
		print("HP is running low : " + str(HP))
		if HP <= 0:
			emit_signal("status_death")
