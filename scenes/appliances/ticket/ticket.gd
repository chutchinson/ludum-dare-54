extends StaticBody
class_name Ticket

var recipe : Recipe setget _set_recipe

func _set_recipe(value: Recipe):
	$MeshInstance/Viewport/TicketInstructions.set_recipe(value)
