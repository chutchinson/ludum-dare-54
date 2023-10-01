extends Node

signal options(pos, options)

func show_options(pos: Vector3, options):
	emit_signal('options', pos, options)
	pass
