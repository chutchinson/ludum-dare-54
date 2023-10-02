extends Station

onready var _anim: AnimationPlayer = get_parent().get_node("AnimationPlayer")

var _opened := false

func inspect(chef: Chef):
	if not _opened: Game.inspect('Open')
	else: Game.inspect('Close')
	
func activate(chef: Chef):
	if not _opened: _open()
	else: _close()
	
func _open():
	if _opened: return
	_opened = true
	_anim.play('open')
	
func _close():
	if not _opened: return
	_opened = false
	_anim.play('close')
