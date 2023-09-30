extends Control

@onready var item_label: Label = $MarginContainer/Label

func _ready():
	Game.picked.connect(_on_picked)
	item_label.modulate.a = 0.0
	
func _on_picked(node: Placeable):
	if node:
		item_label.text = node.display_name
	var tween = create_tween()
	var alpha = 1.0 if node else 0.0
	tween.tween_property(item_label, 'modulate:a', alpha, 0.1)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN_OUT)
	
