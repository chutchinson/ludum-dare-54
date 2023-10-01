extends Station

var count := 3
	
func _activate():
	if count == 0: return
	_show_options([
		TakeAction.new(self, 'Plate')
	])
	
func _update():
	$Plate1.visible = count >= 1
	$Plate2.visible = count >= 2
	$Plate3.visible = count >= 3
	
func take():
	count = max(count - 1, 0)
	# if count == 0: count = 3
	_update()
