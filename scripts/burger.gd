extends MeshInstance

func _process(delta):
	rotate_y(deg2rad(15.0) * delta)
