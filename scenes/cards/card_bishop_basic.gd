extends CardResource
class_name CardBishopBasic

func _init() -> void:
	action_count = 1
	card_name = "Bishop"
	description = \
"Move action: Move diagonally as far as you want
Attack action: Attack diagonally as far as you want."


func get_available_positions(my_pos:Vector2i) -> Array[Vector2i]:
	var ret:Array[Vector2i] = []
	
	const DIAG = Vector2(1,1)
	ret.append_array(get_move_far_tiles(DIAG, my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(DIAG, 90), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(DIAG, 180), my_pos))
	ret.append_array(get_move_far_tiles(Global.rotate_vec2i(DIAG, 270), my_pos))
	
	return ret

func get_sprite_coords() -> Vector2i:
	return Vector2i(2, 0)
