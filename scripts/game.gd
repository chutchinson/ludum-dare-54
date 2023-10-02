extends Node

const SCORE = preload('res://scenes/ui/score.tscn')

signal inspected(text)
signal order_complete()
signal score(value)

var score := 0
var waste := 0
var over := false

var _last_inspection = ''

func game_over():
	if over: return
	over = true
	inspect('Game Over')
	get_tree().change_scene_to(SCORE)
	
func trash_ingredient(_score: int):
	if over: return
	score -= _score
	if score < 0: score = 0
	emit_signal('score', score)

func submit_order(_score: int, _perfect: bool):
	if over: return
	print('score = %d, perfect = %s' % [ _score, _perfect ])
	score += _score
	emit_signal('score', score)
	emit_signal('order_complete', _score, _perfect)

func inspect(text: String):
	if over: 
		emit_signal('inspected', 'Game Over')
		return
	if _last_inspection != text:
		_last_inspection = text
		emit_signal('inspected', text)
