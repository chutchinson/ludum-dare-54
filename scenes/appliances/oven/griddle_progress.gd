extends Control
class_name GriddleProgress

export var value : float setget _set_value
export var tint: Color setget _set_tint

func _set_value(value: float):
	$TextureProgress.value = value * 100.0

func _set_tint(value: Color):
	$TextureProgress.tint_progress = value
