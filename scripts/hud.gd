extends Control

onready var time_label: Label = $MarginContainer/TimeLabel
onready var options: Control = $Options

const WARNING_THRESHOLD := 15.0

var time := 300.0
var warning := false

func _process(delta):
	time = max(time - delta, 0)
	
	var minutes = time / 60
	var seconds = fmod(time, 60)
	var time_remaining = str('%01d:%02d' % [minutes, seconds])
	
	time_label.text = str(time_remaining)
	
	if time <= WARNING_THRESHOLD and not warning:
		_begin_warning()
		
func _begin_warning():
	warning = true
	
	var tween = create_tween()
	tween.tween_property(time_label, 'modulate', Color(1.0, 0.0, 0.0, 1.0), 0.2)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(0.2)
	tween.tween_property(time_label, 'modulate', Color(1.0, 1.0, 1.0, 1.0), 0.2)
	tween.set_loops(-1)
