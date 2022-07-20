extends RigidBody2D


signal spawn_be_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hurtbox.connect("be_hit", self, "_be_hit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _be_hit(area):
	emit_signal("spawn_be_hit", area, get_instance_id())
