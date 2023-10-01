extends Action
class_name PlaceAction

var _node: Spatial
var _ingredient: Ingredient

func _init(node: Spatial, ingredient: Ingredient):
	self.text = 'Place %s' % [ingredient.name]
	_node = node
	_ingredient = ingredient

func execute():
	print('place ingredient %s' % [_ingredient.name])
	if _node.has_method('place'):
		_node.call('place', _ingredient)
	

