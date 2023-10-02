extends Station

onready var _start_pos = $Start
onready var _end_pos = $End

var _ingredient: Ingredient = null

func inspect(chef: Chef):
	if _can_place_ingredients(chef):
		Game.inspect('Place %s' % [chef.ingredient.name])
	elif _can_prep(chef):
		Game.inspect('cut vegetals')
	else:
		Game.inspect('')

func activate(chef: Chef):
	if _can_place_ingredients(chef):
		_place(chef)
	elif _can_prep(chef):
		_prep()
		
func _prep():
	for child in _start_pos.get_children():
		child.queue_free()
	
	for idx in range(0, 3):
		var fragment = _ingredient.fragment_scene.instance()
		_end_pos.add_child(fragment)
		fragment.translation = Vector3(0, 0.03 * idx, 0)
		fragment.rotation.y = deg2rad(90.0 * idx)
		
	_ingredient = null
		
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
	if chef.is_holding_ingredient(): return false
	return _ingredient != null and chef.is_holding_tool('knife')
