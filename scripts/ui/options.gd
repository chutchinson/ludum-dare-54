extends VBoxContainer

var _options = null
var _pos := Vector3.ZERO
var _tween: SceneTreeTween = null

func _ready():
	# Game.connect('options', self, '_on_show_options_requested')
	modulate.a = 0.0
	_clear()

func _input(ev):
	if ev is InputEventMouseButton and ev.is_pressed():
		if ev.button_index == BUTTON_RIGHT:
			_hide_options()
	if ev is InputEventKey and ev.is_pressed():
		if ev.scancode == KEY_ESCAPE:
			_hide_options()

func _on_show_options_requested(pos: Vector3, options: Array):
	if _tween != null: 
		yield (_tween, 'finished')
	_show_options(pos, options)

func _hide_options():
	_tween = create_tween()
	_tween.tween_property(self, 'modulate:a', 0.0, 0.3).set_ease(Tween.EASE_IN)
	_tween.tween_callback(self, '_clear')
	
func _clear():
	_tween = null
	for child in get_children():
		child.queue_free()
	
func _process(_delta):
	var viewport = get_viewport()
	var camera = viewport.get_camera()
	var target_pos = camera.unproject_position(_pos)
	rect_position = target_pos
	
func _show_options(pos: Vector3, options: Array):
	_clear()
	_options = options
	_pos = pos
	
	for option in options:
		var button = Button.new()
		button.text = option.text
		button.connect('pressed', self, '_on_select_option', [option])
		add_child(button)
		
	_tween = create_tween()
	_tween.tween_property(self, 'modulate:a', 1.0, 0.1).set_ease(Tween.EASE_IN_OUT)
	
func _on_select_option(option):
	print('selected option %s' % [option.text])
	_hide_options()
	option.execute()
