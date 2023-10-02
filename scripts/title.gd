extends Control

const GAME = preload('res://main.tscn')

onready var _anim = $"../AnimationPlayer"

func _capture():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _start():
	get_tree().change_scene_to(GAME)

func _on_Control_gui_input(event):
	if event is InputEventMouseButton:
		_capture()
		_anim.play('fade_out')
	if event is InputEventJoypadButton:
		_anim.play('fade_out')
