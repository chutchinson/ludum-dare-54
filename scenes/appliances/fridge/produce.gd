extends Station

export(Resource) var ingredient = null

func inspect(chef: Chef):
	var _ingredient = ingredient as Ingredient
	Game.inspect('take %s' % [_ingredient.name])
	
func activate(chef: Chef):
	print('take fud')
