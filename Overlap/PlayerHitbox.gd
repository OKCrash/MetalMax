extends Hitbox

onready var status = Status.new()
var hit_data = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	hit_data["STR"] = status.STR
