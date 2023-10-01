tool
extends EditorScenePostImport

func post_import(scene):
	_modify(scene)
	return scene
	
func _modify(node):
	print('modify %s', node)
	pass
