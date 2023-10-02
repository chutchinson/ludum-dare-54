extends Resource
class_name Ingredient

enum IngredientFlags {
	PREP = 1
	COOK = 2
	PREPARED = 4
	ONLY_ONE = 8
}

export var name := ''
export var scene: PackedScene
export var ingredient_prepared: Resource
export var ingredient_cooked: Resource
export var ingredient_overcooked: Resource
export var cook_time := 10.0
export var burn_time := 15.0
export var height := 0.2

export(IngredientFlags, FLAGS) var flags

func can_prep() -> bool:
	return (flags & IngredientFlags.PREP) == IngredientFlags.PREP

func can_cook() -> bool:
	return (flags & IngredientFlags.COOK) == IngredientFlags.COOK

func is_only_allowed_once() -> bool:
	return (flags & IngredientFlags.ONLY_ONE) == IngredientFlags.ONLY_ONE
	
func is_prepared() -> bool:
	return (flags & IngredientFlags.PREPARED) == IngredientFlags.PREPARED
