extends Station

const PATTY = preload('res://resources/ingredients/patty.tres')
const LETTUCE = preload('res://resources/ingredients/lettuce.tres')

onready var _anim: AnimationPlayer = $AnimationPlayer

var _opened = false
var _ingredients = [
	PATTY,
	LETTUCE
]

func _activate():
	
	if not _opened:
		_show_options([
			BasicAction.new(self, 'Open Fridge')
		])
	else:
		var actions = [
			BasicAction.new(self, 'Close Fridge')
		]
		for ingredient in _ingredients:
			actions.push_back(TakeAction.new(self, ingredient.name))
			
		_show_options(actions)

func take():
	print('take from fridge')

func action():
	if _anim.is_playing():
		yield (_anim, 'animation_finished')
	if _opened: _close()
	else: _open()
	pass
	
func _open():
	_opened = true
	_anim.play('open')
	pass
	
func _close():
	_opened = false
	_anim.play('close')
	pass
