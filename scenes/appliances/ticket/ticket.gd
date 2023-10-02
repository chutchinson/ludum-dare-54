extends StaticBody
class_name Ticket

var recipe : Recipe setget _set_recipe

#func _get_recipe():
#	return recipe
	
func _set_recipe(value: Recipe):
	recipe = value
	$MeshInstance/Viewport/TicketInstructions.set_recipe(value)
