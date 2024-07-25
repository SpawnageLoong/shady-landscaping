extends Control


func _on_back_button_pressed():
	get_tree().current_scene.remove_child(self)


func _on_level_11_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1_1.tscn")
