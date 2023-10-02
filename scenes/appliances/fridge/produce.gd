extends Station

export(Resource) var ingredient = null

func _can_take(chef: Chef) -> bool:
	return not chef.is_holding_ingredient()
	
func _can_return(chef: Chef) -> bool:
	if not chef.is_holding_ingredient(): return false
	return ingredient == chef.ingredient

func inspect(chef: Chef):
	if _can_take(chef):
		Game.inspect('Take %s' % [ingredient.name])
	elif _can_return(chef):
		Game.inspect('Return %s' %  [ingredient.name])
	else:
		Game.inspect('')
		
func activate(chef: Chef):
	if _can_take(chef):
		chef.hold_ingredient(ingredient)
	elif _can_return(chef):
		chef.take_ingredient()
