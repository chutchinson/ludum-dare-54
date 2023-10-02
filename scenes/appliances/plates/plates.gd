extends Station

const PLATE = preload('res://resources/tools/plate.tres')

var count : int = 3
	
func inspect(chef: Chef):
	if _can_return(chef):
		Game.inspect('Return Plate')
	elif _can_take(chef):
		Game.inspect('Take Plate')
	else:
		Game.inspect('')
	
func activate(chef: Chef):
	if _can_return(chef): _return(chef)
	elif _can_take(chef): _take(chef)
	
func _can_return(chef: Chef) -> bool:
	return chef.is_holding_tool('plate')
	
func _can_take(chef: Chef) -> bool:
	if chef.is_holding_any(): return false
	return true
	# return count > 0

func _update():
	$Plate1.visible = count >= 1
	$Plate2.visible = count >= 2
	$Plate3.visible = count >= 3
	
func _return(chef: Chef):
	chef.current_tool = null
	$SfxDrop.play()
	#count += 1
	#_update()
	
func _take(chef: Chef):
	chef.current_tool = PLATE
	$SfxTake.play()
	#count = max(count - 1, 0)
	#_update()
