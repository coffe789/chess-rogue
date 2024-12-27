extends Node2D
class_name BaseEmemy

var hp = 2

var my_cards: Array[CardResource] = [
	CardKnightBasic.new(),
	CardBishopBasic.new(),
	CardKingBasic.new(),
]

var selected_card: CardResource
var next_card: CardResource

func _init():
	add_to_group("enemy")
	
func _ready() -> void:
	pick_selected_card()
	update_label()

func take_damage(hp_loss:int):
	var discard = my_cards.pop_at(randi_range(0, len(my_cards) - 1))
	if len(my_cards) > 0:
		$AnimationPlayer.play("take_damage")
		await $AnimationPlayer.animation_finished
	else:
		$AnimationPlayer.play("die")
		await $AnimationPlayer.animation_finished
		Global.emit_signal("enemy_died")
		queue_free()
		return
	
	if discard == selected_card:
		pick_selected_card()
		
	update_label()


# return array that with only items that are in both a1 and a2
func array_and(a1:Array, a2:Array) -> Array:
	var ret = []
	for item in a1:
		if a2.has(item):
			ret.append(item)
	return ret
	
func get_my_options() -> Array[Vector2i]:
	var ret : Array[Vector2i] = []
	for c in my_cards:
		ret.append_array(c.get_available_positions(Global.global_to_tile_position(global_position)))
	return ret
	
func pick_selected_card():
	if len(my_cards) == 0:
		selected_card = null
	else:
		if !is_instance_valid(next_card):
			next_card = my_cards.pick_random()
		
		selected_card = next_card
		next_card = my_cards.pick_random()
		update_label()

func update_label():
	$Sprite2D/RichTextLabel.text = str(len(my_cards))
	$Sprite2D.frame_coords = selected_card.get_sprite_coords()
	$Sprite2D/Sprite2D.frame_coords = next_card.get_sprite_coords()

func coverage_ai():
	pass
	
func exclude_enemy_tiles(arr:Array[Vector2i]) -> Array[Vector2i]:
	var ret = arr.duplicate(false)
	for tile in ret:
		if Global.is_enemy_on_tile(tile):
			ret.erase(tile)
	return ret

func closeness_ai() -> Vector2i:
	var pt = Global.get_player_tile()
	var my_tile = Global.global_to_tile_position(global_position)
	var options = selected_card.get_available_positions(my_tile)
	
	options = exclude_enemy_tiles(options)
	
	if len(options) == 0:
		return my_tile
	
	var best_tiles = [options[0]]
	for tile in options:
		if pt.distance_squared_to(tile) < pt.distance_squared_to(best_tiles[0]):
			best_tiles = [tile]
		elif pt.distance_squared_to(tile) == pt.distance_squared_to(best_tiles[0]):
			best_tiles.append(tile)
	
	return best_tiles.pick_random()

func move():
	var tween = create_tween()
	var to = closeness_ai() * Global.TILE_SIZE
	var from = global_position
	
	global_position = to
	$Sprite2D.global_position = from
	
	tween.tween_property($Sprite2D, "global_position", Vector2(to), 0.5)
	
	var awaiter = func():
		await tween.finished
		pick_selected_card()
	return awaiter
	
	


func attack_player():
	pass
