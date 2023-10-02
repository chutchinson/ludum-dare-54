extends Resource
class_name Ingredient

enum IngredientFlags {
	PREP = 1
	COOK = 2
	PREPARED = 4
}

export var name := ''
export var scene: PackedScene
export var fragment_scene: PackedScene
export var cook_time := 10.0
export var burn_time := 15.0
export(IngredientFlags, FLAGS) var flags
