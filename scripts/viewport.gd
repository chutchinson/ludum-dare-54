extends Viewport

func _ready():
	var parent = get_parent() as Sprite3D
	parent.texture = get_texture()
