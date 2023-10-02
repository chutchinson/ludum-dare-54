extends Station

export(Resource) var tool_item

func inspect(chef: Chef):
	if _can_take_tool(chef):
		var _tool = tool_item as Tool
		Game.inspect('Take %s' % _tool.name)
	
func activate(chef: Chef):
	if _can_take_tool(chef):
		_take_tool(chef)
		
func return_tool():
	visible = true
	$CollisionShape.disabled = false
	
func _take_tool(chef: Chef):
	chef.current_tool = tool_item
	visible = false
	$CollisionShape.disabled = true
	
func _can_take_tool(chef: Chef):
	return not chef.is_holding_any() and visible
