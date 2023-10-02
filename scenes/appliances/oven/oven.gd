extends Station

onready var _zones = [$GriddleZone1, $GriddleZone2, $GriddleZone3, $GriddleZone4]

func inspect(chef: Chef):
	if _can_place(chef):
		Game.inspect('Place %s' % [ chef.ingredient.name ])
	elif _can_pickup(chef):
		Game.inspect('Pickup')
	else:
		Game.inspect('')

func activate(chef: Chef):
	if _can_place(chef): _place(chef)
	elif _can_pickup(chef): _pickup(chef)
		
func _can_pickup(chef: Chef) -> bool:
	if not chef.is_holding_tool('spatula'): 
		return false
	if chef.is_holding_ingredient():
		return false
	for zone in _zones:
		if zone.cooked:
			return true
	return false
		
func _can_place(chef: Chef) -> bool:
	if not chef.is_holding_ingredient(): return false
	
	var can_cook = (chef.ingredient.flags & Ingredient.IngredientFlags.COOK) == Ingredient.IngredientFlags.COOK
	if not can_cook: return false
	
	var available = 0
	for zone in _zones:
		if not zone.occupied:
			available += 1

	return available > 0

func _pickup(chef: Chef):
	var cooked_ingredient: Ingredient = null
	
	for zone in _zones:
		if zone.cooked:
			cooked_ingredient = zone.pickup()
			break
	
	if cooked_ingredient != null:
		print('cooked ingredient %s', cooked_ingredient.name)
		chef.hold_ingredient(cooked_ingredient)
		

func _place(chef: Chef):
	for zone in _zones:
		if not zone.occupied:
			var ingredient = chef.take_ingredient()
			zone.accept(ingredient)
			return
