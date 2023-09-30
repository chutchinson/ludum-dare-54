extends AudioStreamPlayer

@export var key := ''

func _ready():
	Game.sfx.connect(_oneshot)
	
func _oneshot(key: String):
	if self.key != key: return
	play(0.0)
	
