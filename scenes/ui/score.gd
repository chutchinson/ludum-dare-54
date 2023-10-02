extends Control

onready var score_label = $CenterContainer/VBoxContainer/ScoreLabel

func _ready():
	score_label.text = str(Game.score) + ' pts'
	$AnimationPlayer.play('show')
