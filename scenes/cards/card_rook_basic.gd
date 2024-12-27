extends CardResource
class_name CardRookBasic

func _init() -> void:
	action_count = 1
	card_name = "Rook"
	description = \
"Move action: Move cardinally as far as you want
Attack action: Attack cardinally as far as you want."


func get_available_positions(my_pos:Vector2i) -> Array[Vector2i]:
	var ret:Array[Vector2i] = []
	
	const STRAIGHT = Vector2(1,0)
	
	ret.append_array(get_move_far_tiles(STRAIGHT, my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(STRAIGHT, 90), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(STRAIGHT, 180), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(STRAIGHT, 270), my_pos))
	
	return ret


func get_sprite_coords() -> Vector2i:
	return Vector2i(4, 0)
