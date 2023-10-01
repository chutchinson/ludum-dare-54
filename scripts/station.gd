extends StaticBody
class_name Station

func inspect(chef: Chef):
	pass
	
func activate(chef: Chef):
	pass

func _ready():
	add_to_group('stations', true)
	collision_layer = 2
	print('station ready %s' % self)
	pass
