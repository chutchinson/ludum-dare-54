extends Station

const PATTY = preload('res://resources/ingredients/patty.tres')
const LETTUCE = preload('res://resources/ingredients/lettuce.tres')

onready var _anim: AnimationPlayer = $AnimationPlayer

var _opened = false
var _ingredients = [
	PATTY,
	LETTUCE
]

func _ready():
	collision_layer = 0
	pass

func inspect(chef: Chef):
	return
	if not _opened: Game.inspect('giv')
	else: Game.inspect('shut')
	pass

func activate(chef: Chef):
	return
	if not _opened: _open()
	else: _close()

func _take():
	print('take from fridge')
	
func _open():
	_opened = true
	_anim.play('open')
	pass
	
func _close():
	_opened = false
	_anim.play('close')
	pass
