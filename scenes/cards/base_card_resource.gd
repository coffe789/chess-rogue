# A CardResource contains the data for a single card in the player's deck
# This should be inherited by all other cards
extends Resource
class_name CardResource

var MAX_DEPTH = 7

var card_name : String
var description : String
var action_count : int

# Returned positions are relative to where the player is
# Positions indicate where a card allows you to move/attack
func get_available_positions(player_pos:Vector2i) -> Array[Vector2i]:
	return []


# Return whether action succeeded
func do_move_action() -> bool:
	return true


# Return whether action succeeded
func do_attack_action() -> bool:
	return true


func on_discard() -> void:
	pass


func get_move_far_tiles(dir : Vector2i, tile:Vector2i) -> Array[Vector2i]:
	var depth = 0
	var ret:Array[Vector2i] = []
	
	tile += dir
	while Global.is_floor_tile(tile) and depth < MAX_DEPTH:
		ret.append(tile)
		if Global.is_enemy_on_tile(tile):
			return ret
		
		tile += dir
		depth += 1
	return ret

func get_sprite_coords() -> Vector2i:
	return Vector2.ZERO
