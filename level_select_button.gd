extends TextureButton

@export var scene_path: String = "res://Levels/level_1_1.tscn"


func _on_pressed():
	SceneTransitions.transition_to(scene_path)
