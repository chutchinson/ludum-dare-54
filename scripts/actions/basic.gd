extends Action
class_name BasicAction

var _node: Spatial

func _init(node: Spatial, text: String):
	self.text = text
	_node = node
	
func execute():
	if _node.has_method('action'):
		_node.call('action')
