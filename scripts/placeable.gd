extends StaticBody
class_name Placeable

const COOLDOWN := 0.2
const HEIGHT_PICKED := 0.2

export var display_name := 'Desk'
export(Array, NodePath) var meshes: Array = []

var picked := false setget _set_picked
var valid := true setget _set_valid

var _mesh = null
var _offset := Vector3.ZERO
var _cooldown := 0.0

func _ready():
	connect('input_event', self, '_on_input_event')
	# input_event.connect('_on_input_event')
	
	# do we have to do this at runtime?
#	for mesh in meshes:
#		var node = get_node(mesh) as MeshInstance
#		var material = node.get_active_material(0)
#		node.set_surface_override_material(0, material.duplicate())

func _set_picked(state):
	picked = state
	valid = false
	#if state: Game.picked.emit(self)
	#else: Game.picked.emit(null)
	var tween = create_tween()
	tween.tween_property(self, 'translation:y', HEIGHT_PICKED if state else 0.0, 0.1)
	tween.set_ease(Tween.EASE_IN_OUT)
	
func _set_valid(state):
	if valid == state: return	
	valid = state
	print('set valid = %s' % state)
	for mesh in meshes:
		var node = get_node(mesh) as MeshInstance
		var material = node.get_active_material(0) as ShaderMaterial
		if material != null:
			material.set_shader_parameter('selected', state)

func _debug(pos: Vector3):
	if _mesh != null:
		_mesh.queue_free()
		_mesh = MeshInstance.new()
	
	var sphere = SphereMesh.new()
	sphere.radius = 0.2
	sphere.height = sphere.radius * 2.0
	_mesh.mesh = sphere
	add_child(_mesh)
	_mesh.global_position = pos
	pass

func _on_input_event(camera: Camera, event, position: Vector3, normal, shape_idx):
	if event.is_action_released('item_place'):
		_pick(position)
			
func _input(ev):
	if ev.is_action_pressed('item_place'):
		_place()
	if ev.is_action_pressed('item_rotate'):
		_rotate()
			
func _process(delta):
	_cooldown = max(_cooldown - delta, 0.0)
	
	if not picked: return

	var world = get_world()
	var viewport = get_viewport()
	var camera = viewport.get_camera()
	var pos = viewport.get_mouse_position()
	var origin = camera.project_ray_origin(pos)
	var normal = camera.project_ray_normal(pos)
	
	var plane = Plane(Vector3.UP, 0.0)
	var intersection = plane.intersects_ray(origin, normal)
	
	if intersection != null:
		intersection.y = global_translation.y
		global_translation = intersection
		
	_check_position()
	
	pass
	
func _check_position():
	pass

func _reset_cooldown():
	_cooldown = COOLDOWN

func _rotate():
	if not picked: return
	
	var target_rotation = rotation.y - deg2rad(90.0)
	var tween = create_tween()
	tween.tween_property(self, 'rotation:y', target_rotation, 0.1)
	tween.set_trans(Tween.TRANS_ELASTIC)
	pass

func _will_collide() -> bool:
	return true

func _pick(position: Vector3):
	if picked: return
	if _cooldown > 0.0: return
	
	_set_picked(true)
	# self.picked = true
	valid = true
	
	#_debug(position)
	_reset_cooldown()
	
	# Game.sfx.emit('pickup')
	
	var origin = global_transform.origin
	position.y = 0.0
	origin.y = 0.0
	_offset = position - origin
	print('picked')

func _place():
	if not picked: return
	# Game.sfx.emit('place')
	_set_picked(false)
	_reset_cooldown()
	print('placed')
