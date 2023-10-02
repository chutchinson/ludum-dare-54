extends Station

export(NodePath) var order_tray_path
 
func _can_activate() -> bool:
	return $AnimationPlayer.is_playing() == false

func inspect(chef: Chef):
	Game.inspect('Order Up!')
	pass

func activate(chef: Chef):
	if not _can_activate(): return
	$AnimationPlayer.play('activate')

func _on_AnimationPlayer_animation_finished(anim_name):
	var tray = get_node(order_tray_path) as OrderTray
	tray.submit()
