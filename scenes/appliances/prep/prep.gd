extends Station

var _occupied := false

func inspect(chef: Chef):
	if _can_place_plate(chef):
		Game.inspect('Place Plate')
	else: 
		Game.inspect('')
		
func activate(chef: Chef):
	if _can_place_plate(chef): _place_plate(chef)
		
func _place_plate(chef: Chef):
	if _can_place_plate(chef):
		print('place')
		var scene = chef.current_tool.scene.instance()
		add_child(scene)
		chef.current_tool = null
		_occupied = true

func _can_place_plate(chef: Chef):
	if _occupied: return false
	return chef.is_holding_tool('plate')
