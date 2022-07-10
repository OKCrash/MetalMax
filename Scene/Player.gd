extends KinematicBody2D


onready var parent = get_parent()
var direction = Vector2.RIGHT setget update_current_direction, get_current_direction
var velocity = 32 setget update_velocity, get_velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("IdleRight")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		play_idle_animation(direction)
		return
	direction = input_direction
	set_process_input(false)
	set_process(false)
	var target= parent.get_node("WorldGrid").request_move(self, input_direction)
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
	var target_position = target['position']
	var velocity = target['velocity']
	play_movement_animation(direction)
	var move_direction = (position - target_position).normalized()
	$Tween.interpolate_property($'Sprite', 'position', move_direction * velocity, Vector2(), $AnimationPlayer.current_animation_length,
			Tween.TRANS_LINEAR, Tween.EASE_IN)
	if velocity:
		$Sprite.position = position - target_position
		position = target_position
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
