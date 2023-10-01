extends StaticBody
class_name Station

export var key := ''
export(NodePath) var target_position = null

var target: Position3D setget , _get_target

func _ready():
	connect('input_event', self, '_on_input_event')
	pass
	
func _on_input_event(_camera, ev: InputEvent, _position, _normal, _shape):
	if ev.is_action_pressed('activate'):
		_activate()
		
func _activate():
	pass

func _get_target() -> Position3D:
	return get_node(target_position) as Position3D

func _show_options(options: Array):
	print('show options')
	Game.show_options(global_translation + Vector3.UP, options)
