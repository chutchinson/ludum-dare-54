extends Station

const BOTTOM_BUN = preload('res://resources/ingredients/bun_bottom.tres')
const TOP_BUN = preload('res://resources/ingredients/bun_top.tres')

onready var _order_pos = $Order

var _occupied := false
var _ingredients = []
var _height := 0.0
var _order = null

func inspect(chef: Chef):
	if _can_place_plate(chef):
		Game.inspect('Place Plate')
	elif _can_place_ingredient(chef):
		Game.inspect('Place %s' % [chef.ingredient.name])
	elif _can_take_meal(chef):
		Game.inspect('Pickup Order')
	else: 
		Game.inspect('')
		
func activate(chef: Chef):
	if _can_place_plate(chef): _place_plate(chef)
	elif _can_place_ingredient(chef): _place_ingredient(chef)
	elif _can_take_meal(chef): _take_meal(chef)
	
func _place_ingredient(chef: Chef):
	var ingredient = chef.take_ingredient()
	var node = ingredient.scene.instance()
	
	_order.add_child(node)
	node.translation.y = _height
	node.rotation.y = rand_range(-deg2rad(0), deg2rad(360))
	
	_ingredients.push_back(ingredient)
	_height += ingredient.height
	
func _take_meal(chef: Chef):
	_ingredients.clear()
	_occupied = false
	_height = 0.0
	
	_order.get_parent().remove_child(_order)
	chef.hold_order(_order)
	
func _place_plate(chef: Chef):
	_order = Spatial.new()
	var scene = chef.current_tool.scene.instance()
	_order.add_child(scene)
	_order_pos.add_child(_order)
	_occupied = true
	chef.current_tool = null

func _has_ingredient(ingredient: Ingredient) -> bool:
	for x in _ingredients:
		if x == ingredient:
			return true
	return false
	
func _can_take_meal(chef: Chef) -> bool:
	return _has_ingredient(TOP_BUN) and not chef.is_holding_any()
	
func _can_place_ingredient(chef: Chef) -> bool:
	if not _occupied: return false
	if not chef.is_holding_ingredient(): return false
	if not chef.ingredient.is_prepared(): return false
	if not chef.ingredient == BOTTOM_BUN and not _has_ingredient(BOTTOM_BUN): return false
	if _has_ingredient(TOP_BUN): return false
	
	var count = 0
	
	for x in _ingredients:
		if chef.ingredient == x:
			count += 1
		if chef.ingredient.is_only_allowed_once() and count > 1:
			print('count %d' % count)
			return false
			
	return true
	

func _can_place_plate(chef: Chef):
	if _occupied: return false
	return chef.is_holding_tool('plate')
