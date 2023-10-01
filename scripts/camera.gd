extends Camera

export var speed := 5.0

func _process(delta):
	var horizontal = Input.get_axis('move_left', 'move_right')
	var vertical = Input.get_axis('move_back', 'move_forward')

	var forward = -transform.basis.z
	forward.y = 0.0

	var input = transform.basis.x * horizontal + forward.normalized() * vertical
	var dir = input.normalized()

	if abs(dir.length_squared()) > 0.0:
		global_translation += dir * delta * speed
