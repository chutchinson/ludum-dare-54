extends Camera

var _bob := 0.0
var _original_fov := 0.0
var _tween: SceneTreeTween = null

func _ready():
	_original_fov = fov

func _zoom(to: float):
	if _tween != null:
		_tween.kill()
		_tween = null
	_tween = create_tween()
	_tween.tween_property(self, 'fov', to, 0.225)

func _process(delta):
	if Input.is_action_just_pressed('zoom'):
		_zoom(_original_fov * 0.5)
	elif Input.is_action_just_released('zoom'):
		_zoom(_original_fov)

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
