extends KinematicBody2D


onready var parent = get_parent()
onready var rayCast = $RayCast2D

var direction = Vector2.RIGHT setget update_current_direction, get_current_direction
var velocity = 32 setget update_velocity, get_velocity

signal encounter_battle

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("IdleRight")
	rayCast.enabled = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		play_idle_animation(direction)
		return
	direction = input_direction
	if not is_target_valid():
		return
	set_process_input(false)
	set_process(false)
	var target = position + velocity * direction
	$Tween.start()
	yield(move_to(target), "completed")
	set_process(true)
	set_process_input(true)	
	

# Get input strength and direction.
func get_input_direction():
	var input_strength = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	if input_strength.x and input_strength.y:
		input_strength.x = 0
	return input_strength
	
		
# Move to target tile
func move_to(target):
#	var velocity = direction * velocity
	play_movement_animation(direction)
	if velocity:
		$Tween.interpolate_property(self, 'position', position, target, $AnimationPlayer.current_animation_length,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	yield($AnimationPlayer, 'animation_finished')

func play_movement_animation(direction):
	if direction:
		match direction:
			Vector2.RIGHT:
				$AnimationPlayer.play("RunRight")
			Vector2.LEFT:
				$AnimationPlayer.play("RunLeft")
			Vector2.UP:
				$AnimationPlayer.play("RunUp")
			Vector2.DOWN:
				$AnimationPlayer.play("RunDown")


func play_idle_animation(direction):
	if direction:
		match direction:
			Vector2.RIGHT:
				$AnimationPlayer.play("IdleRight")
			Vector2.LEFT:
				$AnimationPlayer.play("IdleLeft")
			Vector2.UP:
				$AnimationPlayer.play("IdleUp")
			Vector2.DOWN:
				$AnimationPlayer.play("IdleDown")


func update_current_direction(newDirection):
	if direction:
		direction = newDirection
	

func get_current_direction():
	return direction
	

func update_velocity(newVelocity):
	velocity = newVelocity
	
	
func get_velocity():
	return velocity
	

func _physics_process(delta):
	rayCast.cast_to = direction * velocity
	if Input.is_action_just_released("ui_select"):
		if rayCast.is_colliding():
			var obj = rayCast.get_collider()
			print('Found : ' + str(obj.get("encounter_battle")))
			if obj.get('encounter_battle'):
				print('Ready to fight!')
				emit_signal("encounter_battle")
		else:
			print('Nothing else!')
			

# Collision detect before moving
func is_target_valid():
	if direction:
		var is_collided = move_and_collide(direction * velocity, true, true, true)
		if is_collided:
			return false
		else:
			return true
#		
