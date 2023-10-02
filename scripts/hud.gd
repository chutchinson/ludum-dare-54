extends Control

onready var action_label: Label = $CenterContainer/ActionLabel
onready var time_label: Label = $MarginContainer/TimeLabel
onready var score_label: Label = $MarginContainer2/ScoreLabel

const WARNING_THRESHOLD := 15.0

var time := 300.0
var warning := false

var _tween: SceneTreeTween

func _ready():
	Game.connect('inspected', self, '_on_inspection')
	Game.connect('score', self, '_on_score')
	action_label.text = ''
	action_label.modulate.a = 0.0
	pass
	
func _on_score(score: int):
	score_label.text = str(score)

func _on_inspection(text: String):
	if _tween != null:
		_tween.kill()
		_tween = null
	if len(text) == 0:
		_tween = create_tween()
		_tween.parallel().tween_property(action_label, 'rect_scale', Vector2(0.0, 0.0), 0.125)
		_tween.parallel().tween_property(action_label, 'modulate:a', 0.0, 0.125)
		_tween.tween_callback(self, '_set_action_text', [text])
	else:
		_set_action_text(text)
		_tween = create_tween()
		_tween.parallel().tween_property(action_label, 'rect_scale', Vector2(1.0, 1.0), 0.125)
		_tween.parallel().tween_property(action_label, 'modulate:a', 1.0, 0.125)
		
func _set_action_text(text: String):
	action_label.text = text
	action_label.rect_pivot_offset = action_label.rect_size * 0.5

func _process(delta):
	time = max(time - delta, 0)
	
	var minutes = time / 60
	var seconds = fmod(time, 60)
	var time_remaining = str('%01d:%02d' % [minutes, seconds])
	
	time_label.text = str(time_remaining)
	
	if time <= WARNING_THRESHOLD and not warning:
		_begin_warning()
	if time <= 0:
		Game.game_over()
		
func _begin_warning():
	warning = true
	
	var tween = create_tween()
	tween.tween_property(time_label, 'modulate', Color(1.0, 0.0, 0.0, 1.0), 0.2)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(0.2)
	tween.tween_property(time_label, 'modulate', Color(1.0, 1.0, 1.0, 1.0), 0.2)
	tween.set_loops(-1)
