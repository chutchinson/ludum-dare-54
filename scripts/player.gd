extends Spatial

export var speed := 5.0

onready var _gimbal = $Gimbal

var _captured := false
var _rotation := Vector3.ZERO

func _release():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_captured = false
	
func _capture():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_captured = true
	
func _input(ev):
	if ev is InputEventKey:
		if ev.scancode == KEY_ESCAPE:
			_release()
	if ev is InputEventMouseButton:
		if ev.is_pressed() and ev.button_index == BUTTON_LEFT:
			if not _captured: _capture()
	if ev is InputEventMouseMotion and _captured:
		rotation.y -= ev.relative.x * 0.004
		_gimbal.rotation.x -= ev.relative.y * 0.004
		_gimbal.rotation.x = clamp(_gimbal.rotation.x, deg2rad(-90), deg2rad(90))
		pass
	pass
	
func _physics_process(delta):
	if not _captured: return
	
	var horizontal = Input.get_axis('move_left', 'move_right')
	var forward = Input.get_axis('move_back', 'move_forward')
	var dir = transform.basis.x * horizontal - transform.basis.z * forward
	var direction = dir.normalized()
	
	if direction.length_squared() > 0.0:
		global_translation += direction * delta * speed
		
	pass
