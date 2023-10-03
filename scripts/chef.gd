extends KinematicBody
class_name Chef

export var gravity := -10.0
export var speed := 5.0
export var look_sensitivity = 0.15

onready var _is_web = OS.has_feature('web')

var moving := false

onready var _hand = $Gimbal/Camera/RightHand
onready var _item_pos = $Gimbal/Camera/RightHand/ItemPos
onready var _tool_pos = $Gimbal/Camera/RightHand/ToolPos
onready var _gimbal = $Gimbal
onready var _raycast = $Gimbal/Camera/RayCast

var ingredient: Ingredient setget , _get_ingredient
var current_tool: Tool setget _set_tool, _get_tool

var _captured := false
var _tool: Tool = null
var _ingredient: Ingredient = null
var _velocity = Vector3.ZERO
var _order: Spatial = null

func _get_ingredient() -> Ingredient:
	return _ingredient
	
func _get_tool() -> Tool:
	return _tool
	
func _set_tool(item: Tool):	
	_set_hand(item.scene if item else null)
	_tool = item
	
func is_holding_any() -> bool:
	return is_holding_tool('') or is_holding_order() or is_holding_ingredient()

func is_holding_tool(key: String) -> bool:
	if _tool == null: return false
	if len(key) == 0: return true
	return _tool.key == key

func is_holding_order() -> bool:
	return _order != null

func is_holding_ingredient() -> bool:
	return _ingredient != null

func take_ingredient() -> Ingredient:
	$SfxGrab.play(0.0)
	var temp = _ingredient
	for child in _item_pos.get_children():
		child.queue_free()
	_ingredient = null
	return temp
	
func _set_hand(scene: PackedScene) -> Node:
	for child in _tool_pos.get_children():
		child.queue_free()
	
	if scene == null: return null
	
	var node = scene.instance()
	_tool_pos.add_child(node)
	return node
	
func take_order() -> Spatial:
	if not _order: return null
	var node = _order
	_order.get_parent().remove_child(_order)
	_order = null
	return node
	
func hold_order(order: Spatial):
	_item_pos.add_child(order)
	_order = order

func hold_ingredient(ingredient: Ingredient):
	$SfxGrab.play(0.0)
	for child in _item_pos.get_children():
		child.queue_free()
	var node = ingredient.scene.instance()
	_item_pos.add_child(node)
	_ingredient = ingredient

func _ready():
	if not OS.has_feature('web'):
		_capture()
	else:
		_captured = true

func _capture():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_captured = true
	
func _release():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_captured = false

func _input(ev):
	if ev is InputEventKey:
		if ev.is_pressed() and ev.scancode == KEY_ESCAPE:
			_release()
	if ev is InputEventMouseButton:
		if ev.is_pressed() and ev.button_index == BUTTON_LEFT:
			_capture()
	if ev is InputEventMouseMotion and _captured:
		var sensitivity = look_sensitivity
		var dx = clamp(ev.relative.x * look_sensitivity, -8.0, 8.0)
		var dy = clamp(ev.relative.y * look_sensitivity, -8.0, 8.0)
		rotate_y(deg2rad(-dx))
		_gimbal.global_rotation.x -= deg2rad(dy)
		_gimbal.global_rotation.x = clamp(_gimbal.global_rotation.x, deg2rad(-90.0), deg2rad(90.0))
		
func _check_raycast():
	if not _raycast.is_colliding(): 
		Game.inspect('')
		return
	
	var collider = _raycast.get_collider()
	
	if collider and collider.is_in_group('stations'):
		collider.inspect(self)
		if Input.is_action_just_pressed('activate'):
			collider.activate(self)
	else:
		Game.inspect('')
		
func _process(delta):
	_check_raycast()
	
	var horizontal = Input.get_axis('move_left', 'move_right')
	var vertical = Input.get_axis('move_back', 'move_forward')
	
	var forward = -transform.basis.z
	forward.y = 0.0
	
	var input = transform.basis.x * horizontal + forward.normalized() * vertical
	var dir = input.normalized()
	
	if abs(dir.length_squared()) > 0.0:
		if not $SfxStep.playing:
			$SfxStep.playing = true
		moving = true
		_velocity.x = dir.x * speed
		_velocity.z = dir.z * speed
	else:
		$SfxStep.playing = false
		moving = false
		_velocity.x = 0.0
		_velocity.z = 0.0
	
	_velocity.y += gravity * delta
	
func _physics_process(delta):

	_velocity = move_and_slide(_velocity, Vector3.UP, false, 4, 0.785398,false)
		
	if Input.is_action_just_pressed('jump') and is_on_floor():
		_velocity.y = 2.0
