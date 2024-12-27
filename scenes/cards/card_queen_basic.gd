extends CardResource
class_name CardQueenBasic

func _init() -> void:
	action_count = 1
	card_name = "Queen"
	description = \
"Move action: Move as far as you want
Attack action: Attack as far as you want."


func get_available_positions(my_pos:Vector2i) -> Array[Vector2i]:
	var ret:Array[Vector2i] = []
	
	const DIAG = Vector2(1,1)
	const STRAIGHT = Vector2(1,0)
	ret.append_array(get_move_far_tiles(DIAG, my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(DIAG, 90), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(DIAG, 180), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(DIAG, 270), my_pos))
	
	ret.append_array(get_move_far_tiles(STRAIGHT, my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(STRAIGHT, 90), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(STRAIGHT, 180), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(STRAIGHT, 270), my_pos))
	
	return ret


func get_sprite_coords() -> Vector2i:
	return Vector2i(1, 0)
