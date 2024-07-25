extends Control

@onready var main_menu: Control = $menu
@onready var level_select: Control = $level_select


func _on_new_game_button_pressed():
	GlobalVariables.in_demo_mode = false
	SceneTransitions.transition_to("res://Levels/level_1_1.tscn")


func _on_level_select_button_pressed():
	## var level_select_scene = load("res://UI/level_select.tscn").instantiate()
	## get_tree().current_scene.add_child(level_select_scene)
	main_menu.visible = false
	main_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	level_select.visible = true
	level_select.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_settings_button_pressed():
	var settings_scene = load("res://UI/settings.tscn").instantiate()
	get_tree().current_scene.add_child(settings_scene)


func _on_back_button_pressed():
	level_select.visible = false
	level_select.mouse_filter = Control.MOUSE_FILTER_IGNORE
	main_menu.visible = true
	main_menu.mouse_filter = Control.MOUSE_FILTER_STOP
