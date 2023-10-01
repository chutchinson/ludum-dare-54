extends Node

signal inspected(text)

var _last_inspection = ''

func inspect(text: String):
	if _last_inspection != text:
		_last_inspection = text
		emit_signal('inspected', text)
