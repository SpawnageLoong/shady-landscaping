extends Control

@onready var level_label: Label = $level_label
@onready var water_icon: Sprite2D = $water_icon
@onready var material_icon: Sprite2D = $material_icon
@onready var potion_icon: Sprite2D = $potion_icon


func _process(_delta):
	level_label.text = GlobalVariables.current_level
	if PlayerVariables.has_water:
		water_icon.frame = 1
	else:
		water_icon.frame = 0
	if PlayerVariables.player_material == "ice_flower":
		material_icon.frame = 1
	elif PlayerVariables.player_material == "fire_flower":
		material_icon.frame = 2
	else:
		material_icon.frame = 0
	if PlayerVariables.player_potion == "ice_potion":
		potion_icon.frame = 1
	elif PlayerVariables.player_potion == "fire_potion":
		potion_icon.frame = 2
	else:
		potion_icon.frame = 0

func _on_restart_button_pressed():
	var level_path = "res://Levels/" + GlobalVariables.level_path_name +  ".tscn"
	SceneTransitions.transition_to(level_path)


func _on_menu_button_pressed():
	SceneTransitions.transition_to("res://UI/main_menu.tscn")


func _on_left_button_pressed():
	var left_button_event = InputEventAction.new()
	left_button_event.action = "move_left"
	left_button_event.pressed = true
	Input.parse_input_event(left_button_event)


func _on_up_button_pressed():
	var up_button_event = InputEventAction.new()
	up_button_event.action = "move_up"
	up_button_event.pressed = true
	Input.parse_input_event(up_button_event)


func _on_down_button_pressed():
	var down_button_event = InputEventAction.new()
	down_button_event.action = "move_down"
	down_button_event.pressed = true
	Input.parse_input_event(down_button_event)


func _on_interact_button_pressed():
	var interact_button_event = InputEventAction.new()
	interact_button_event.action = "interact"
	interact_button_event.pressed = true
	Input.parse_input_event(interact_button_event)


func _on_right_button_pressed():
	var right_button_event = InputEventAction.new()
	right_button_event.action = "move_right"
	right_button_event.pressed = true
	Input.parse_input_event(right_button_event)
