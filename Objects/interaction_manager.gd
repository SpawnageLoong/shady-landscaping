extends Node2D

var label_y_offset = -12
var label_x_offset = 12

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Sprite2D

const base_label = "[E] to "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)


func _process(_delta):
	update()


func update():
	if active_areas.size() > 0 && can_interact && !GlobalVariables.in_demo_mode:
		active_areas.sort_custom(_sort_by_player_direction)
		## label.text = base_label + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y += label_y_offset
		label.global_position.x += label_x_offset
		label.show()
	else:
		label.hide()


func hide_label():
	label.hide()


func _sort_by_player_direction(area1, _area2):
	var player_direction = PlayerVariables.player_direction
	var player_to_area1 = area1.global_position - player.global_position
	var vector_player_to_area1 = Vector2(player_to_area1.x, player_to_area1.y)
	var vector_direction = vector_player_to_area1.normalized().snapped(Vector2.ONE)
	return vector_direction == player_direction


func interact():
	if active_areas.size() > 0:
			can_interact = false
			label.hide()
			await active_areas[0].interact.call()
			can_interact = true


func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		interact()
