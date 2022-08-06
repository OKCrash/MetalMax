extends Area2D

func _on_Area2D_body_entered(body):
	if body:
		print("Enter a dungeon!")
		emit_signal("switch_scene")
