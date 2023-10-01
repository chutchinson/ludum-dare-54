extends Station

const PATTY = preload('res://resources/ingredients/patty.tres')

onready var _placements = [$Item1, $Item2, $Item3, $Item4]
var _items := 0

func _activate():
	if _items >= len(_placements): 
		return
		
	_show_options([
		PlaceAction.new(self, PATTY)
	])

func place(ingredient: Ingredient):
	var placement = _placements[_items]
	var scene = ingredient.scene.instance()
	placement.add_child(scene)
	_items += 1
	pass
