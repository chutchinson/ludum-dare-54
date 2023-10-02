extends Station

func inspect(chef: Chef):
	if _can_trash(chef):
		if chef.is_holding_ingredient():
			Game.inspect('Dispose %s' % chef.ingredient.name)
		else:
			Game.inspect('Dispose Order')
	else:
		Game.inspect('')

func activate(chef: Chef):
	if _can_trash(chef):
		_trash(chef)
		
func _can_trash(chef: Chef):
	return chef.is_holding_ingredient() or chef.is_holding_order()
	
func _trash(chef: Chef):
	if chef.is_holding_ingredient():
		var ingredient = chef.take_ingredient()
		print('trashed %s' % ingredient.name)
		Game.trash_ingredient(10)
	elif chef.is_holding_order():
		var order = chef.take_order()
		Game.trash_ingredient(50)
		print('trashed order')
	$SfxTrash.play()
