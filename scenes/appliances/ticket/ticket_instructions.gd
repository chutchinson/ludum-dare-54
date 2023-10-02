extends Control

const LABEL = preload('res://scenes/appliances/ticket/recipe_label.tscn')

func set_recipe(recipe: Recipe):
	var items = recipe.get_items()
	var labels = []
	
	_create_alt_label(recipe.name)
	
	if len(items) == 0:
		_create_alt_label('JUST BREAD')
		return
		
	for item in items:
		_create_label(item.ingredient.name, item.count)
	
func _create_alt_label(text: String):
	var container = $MarginContainer/VBoxContainer
	var label = LABEL.instance()
	label.text = text
	container.add_child(label)
	
func _create_label(name: String, count: int):
	var container = $MarginContainer/VBoxContainer
	var label = LABEL.instance()
	label.text = '%dx %s' % [count, name]
	container.add_child(label)
	
