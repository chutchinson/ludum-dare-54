extends Resource
class_name Recipe

export var name := ''
export(Array, Resource) var ingredients = []
export(Array, int) var counts = []

func get_items() -> Array:
	var items = []
	for idx in range(0, len(ingredients)):
		items.push_back({
			'ingredient': ingredients[idx],
			'count': counts[idx]
		})
	return items
