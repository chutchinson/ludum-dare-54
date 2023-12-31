extends Station

onready var _knife = $Knife
onready var _spatula = $Spatula

func inspect(chef: Chef):
	if _can_place_tool(chef):
		Game.inspect('Return %s ' % chef.current_tool.name)
	else:
		Game.inspect('')
		
func activate(chef: Chef):
	if not _can_place_tool(chef): return
	
	# hardcoded because gamejam :)
	match chef.current_tool.key:
		'knife': _knife.return_tool()
		'spatula': _spatula.return_tool()
		
	chef.current_tool = null
	$SfxPlace.play()
	
func _can_place_tool(chef: Chef) -> bool:
	return chef.is_holding_tool('knife') or chef.is_holding_tool('spatula')
