extends Station

const CUT = preload('res://scripts/actions/cut.gd')

func _activate():
	print('prep')
	_show_options([
		CUT.new('Cut Lettuce'),
		CUT.new('Cut Tomato')
	])
