extends Station

func _can_activate() -> bool:
	return $AnimationPlayer.is_playing() == false

func inspect(chef: Chef):
	Game.inspect('Order Up!')
	pass

func activate(chef: Chef):
	if not _can_activate(): return
	$AnimationPlayer.play('activate')

func _on_AnimationPlayer_animation_finished(anim_name):
	print('notify customers')
	pass
