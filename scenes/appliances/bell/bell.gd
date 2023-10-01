extends Spatial

func _can_activate() -> bool:
	return $AnimationPlayer.is_playing() == false

func _activate():
	if not _can_activate(): return
	$AnimationPlayer.play('activate')

func _on_Bell_input_event(camera, event: InputEvent, position, normal, shape_idx):
	if event.is_action_pressed('activate'):
		_activate()

func _on_AnimationPlayer_animation_finished(anim_name):
	# TODO: notify waiting customers
	print('notify customers')
	pass
