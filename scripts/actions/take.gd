extends Action
class_name TakeAction

var node: Spatial

func _init(node: Spatial, text: String):
	self.node = node
	self.text = 'Take %s' % [text]

func execute():
	print('take a plate')
	if node.has_method('take'):
		node.call('take')
