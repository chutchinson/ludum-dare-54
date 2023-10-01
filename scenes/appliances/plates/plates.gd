extends Station

var count := 3
	
func inspect(chef: Chef):
	if count > 0: Game.inspect('steal')
	else: Game.inspect('oh no')
	pass
	
func activate(chef: Chef):
	if count == 0: return
	_take()
	
func _update():
	$Plate1.visible = count >= 1
	$Plate2.visible = count >= 2
	$Plate3.visible = count >= 3
	
func _take():
	count = max(count - 1, 0)
	# if count == 0: count = 3
	_update()
