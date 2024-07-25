extends Control


func _on_back_button_pressed():
	get_tree().current_scene.remove_child(self)
