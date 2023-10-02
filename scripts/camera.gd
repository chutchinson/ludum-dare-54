extends Camera

var _bob := 0.0

func _physics_process(delta):
	var nodes = get_tree().get_nodes_in_group('chef')
	var chef = nodes[0]
	var speed = chef._velocity.length()
	
	if chef.moving:
		translation.y = 0.025 * sin(_bob * TAU * speed * 0.5)
		_bob += delta
	else:
		translation.y = 0.0
		_bob = 0.0
