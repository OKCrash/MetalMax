extends RigidBody2D

enum {
	IDLE,
	MOVE,
	JUMP,
	ATTACK,
	DAMAGED
}

const MAX_VELOCITY = 150.0
const ACCEL_VELOCITY = 400.0
const DEACCEL_VELOCITY = 400.0

var state = IDLE
var is_on_floor = true
var is_jumping = true
var floor_h_velocity = 0.0
var floor_index = -1

func _ready():
	pass


func _integrate_forces(state):
	var lv = linear_velocity
	var delta = state.step
	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_pressed("ui_select")
	var attack = Input.is_action_pressed("ui_attack")
	
	lv.x -= floor_h_velocity
	floor_h_velocity = 0.0
	
	# Find the floor
	for x in range(state.get_contact_count()):
		var ci = state.get_contact_local_normal(x)
		if ci.dot(Vector2.UP) > 0.6:
			is_on_floor = true
			floor_index = x
	
	# Attack process
	if attack:
		pass
			
	# Jump process
	if is_jumping:
		if lv.y > 0:
			is_jumping = false
		elif not jump:
			pass
	
	# Movement process
	if move_left and not move_right:
		if lv.x > -MAX_VELOCITY:
			lv.x -= ACCEL_VELOCITY * delta
	elif move_right and not move_left:
		if lv.x < MAX_VELOCITY:
			lv.x += ACCEL_VELOCITY * delta
	else:
		var vx = abs(lv.x)
		vx -= DEACCEL_VELOCITY * delta
		if vx < 0:
			vx = 0
		lv.x = sign(lv.x) * vx
	print(str(lv))
	if is_on_floor:
		floor_h_velocity = state.get_contact_collider_velocity_at_position(floor_index).x
		lv.x += floor_h_velocity
	state.linear_velocity = lv
		
