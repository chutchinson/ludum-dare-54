extends Node

onready var _sprite: Sprite3D = $Sprite3D
onready var _progress = $Sprite3D/Viewport/GriddleProgress
onready var _timer: Timer = $Timer

onready var _anim: AnimationPlayer = $AnimationPlayer

var _node: Node = null
var _ingredient: Ingredient = null

var occupied setget , _get_occupied
var cooked := false
var burning := false
var burnt := false

func _get_occupied() -> bool:
	return _node != null

func pickup() -> Ingredient:
	_anim.play('RESET')
	
	if _node != null: 
		_node.queue_free()
		_node = null
	
	var cooked_ingredient = _ingredient
	_ingredient = null
	
	cooked = false
	burning = false
	
	$SfxSizzle.stop()
	
	return cooked_ingredient

func accept(ingredient: Ingredient):
	_ingredient = ingredient
	_node = ingredient.scene.instance()
	_progress.value = 0
	_timer.wait_time = ingredient.cook_time
	_anim.play('cook')
	
	add_child(_node)
	cooked = false
	
	$SfxSizzle.play()
	
func _process(_delta):
	if _node == null: return
	var value = _timer.time_left / _timer.wait_time
	_progress.value = 1.0 - value

func _on_Timer_timeout():
	if not _ingredient:
		return
	if not cooked:
		cooked = true
		burning = true
		
		var cooked_ingredient = _ingredient.ingredient_cooked

		_node.queue_free()
		_node = cooked_ingredient.scene.instance()
		_ingredient = cooked_ingredient
		add_child(_node)
		
		_timer.wait_time = _ingredient.burn_time
		_anim.play('burning')
