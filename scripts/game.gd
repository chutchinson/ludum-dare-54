extends Node

signal inspected(text)
signal order_complete()

var _last_inspection = ''

func submit_order():
	emit_signal('order_complete')

func inspect(text: String):
	if _last_inspection != text:
		_last_inspection = text
		emit_signal('inspected', text)
