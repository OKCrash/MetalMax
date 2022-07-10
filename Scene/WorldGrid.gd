extends TileMap


enum tileType {NPC, OBSTACLE, BOX}
onready var parent = get_parent()
onready var player = parent.get_node("Player")


func request_move(cellObject, moveDirection):
	var startTile = world_to_map(cellObject.position)
	var targetTile = startTile + moveDirection
	var target_position  = map_to_world(targetTile)
	var target = {'position': target_position}
	target['velocity'] = is_target_valid(moveDirection)
	return target


# Collision detect before moving
func is_target_valid(moveDirection):
	if moveDirection:
		var is_collided = player.move_and_collide(moveDirection * 32, true, true, true)
		if is_collided:
			print('Oops, a wall, we need to find another way.')
			return 0
		else:
			return 32
