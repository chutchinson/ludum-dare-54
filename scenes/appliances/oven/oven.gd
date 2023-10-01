extends Station

const PATTY = preload('res://resources/ingredients/patty.tres')

onready var _placements = [$Item1, $Item2, $Item3, $Item4]
var _items := 0

func inspect(chef: Chef):
	Game.inspect('cook fud')
	pass

func activate(chef: Chef):
	if _items >= len(_placements): 
		return
	_place(PATTY)

func _place(ingredient: Ingredient):
	var placement = _placements[_items]
	var scene = ingredient.scene.instance()
	placement.add_child(scene)
	_items += 1
