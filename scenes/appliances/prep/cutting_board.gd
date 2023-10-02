extends Station

onready var _start_pos = $Start
onready var _end_pos = $End

var _ingredient: Ingredient = null

func inspect(chef: Chef):
	if _can_place_ingredients(chef):
		Game.inspect('Place %s' % [chef.ingredient.name])
	elif _can_prep(chef):
		Game.inspect('Chop')
	elif _can_take(chef):
		Game.inspect('Take %s' % [_ingredient.name])
	else:
		Game.inspect('')

func activate(chef: Chef):
	if _can_place_ingredients(chef):
		_place(chef)
	elif _can_prep(chef):
		_prep()
	elif _can_take(chef):
		_take(chef)
		
func _can_take(chef: Chef) -> bool:
	if chef.is_holding_any(): return false
	return _ingredient != null and _ingredient.is_prepared()
	
func _take(chef: Chef):
	for child in _end_pos.get_children():
		child.queue_free()
	chef.hold_ingredient(_ingredient)
	_ingredient = null
	
func _prep():
	for child in _start_pos.get_children():
		child.queue_free()
	
	for idx in range(0, 3):
		var ingredient_prepared = _ingredient.ingredient_prepared as Ingredient
		var node = ingredient_prepared.scene.instance()
		_end_pos.add_child(node)
		node.translation = Vector3(0, 0.03 * idx, 0)
		node.rotation.y = deg2rad(90.0 * idx)
		
	_ingredient = _ingredient.ingredient_prepared as Ingredient
		
func _place(chef: Chef):
	_ingredient = chef.take_ingredient()
	var scene = _ingredient.scene.instance()
	_start_pos.add_child(scene)

func _can_place_ingredients(chef: Chef) -> bool:
	if _ingredient != null: return false
	if not chef.is_holding_ingredient(): return false
	var can_prep = (chef.ingredient.flags & Ingredient.IngredientFlags.PREP) == Ingredient.IngredientFlags.PREP
	return can_prep

func _can_prep(chef: Chef) -> bool:
	if chef.is_holding_order(): return false
	if chef.is_holding_ingredient(): return false
	if _ingredient == null: return false
	return _ingredient.can_prep() and chef.is_holding_tool('knife')
