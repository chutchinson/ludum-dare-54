extends Viewport

func _ready():
	var parent = get_parent() as MeshInstance
	var material = parent.get_active_material(1) as ShaderMaterial
	material.set_shader_param('albedo_texture', get_texture())
	material.set_shader_param('tint', Color(1.0, 0.0, 0.0, 1.0))
