extends KinematicBody

export var speed := 2.5

var place := -1
var places := ['oven', 'prep', 'fridge', 'plates']

func _go_to_station(key: String):
	var stations = get_tree().get_nodes_in_group('stations')
	for station in stations:
		if station.key == key:
			var target_position = station.target
			_move_to(target_position.global_translation, target_position.global_rotation)
			
func _input(ev: InputEvent):
	if ev.is_action_pressed('debug'):
		print('debug')
		place = wrapi(place + 1, 0, len(places))
		_go_to_station(places[place])
		pass

func _move_to(pos: Vector3, rotation: Vector3):
	var tween = create_tween()
	var direction = global_translation.direction_to(pos)
	# var dir = Vector3(direction.z, 0.0, 0.0)
	# look_at(global_translation + dir, Vector3.UP)
	tween.tween_property(self, 'global_translation', pos, 1.0 * (1.0 / speed))
	tween.tween_property(self, 'global_rotation', rotation, 0.2)

func _ready():
	# _go_to_station('prep')
	pass
	
func _process(delta):
	# global_translation += Vector3.BACK * delta * speed
	pass
