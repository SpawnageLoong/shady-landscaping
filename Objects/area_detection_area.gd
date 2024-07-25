extends Area2D
class_name AreaDetectionArea

@export var target_area_name = "shadow"

var area_detected = false
var areas = []

func _process(_delta):
	if areas.size() > 0:
		area_detected = true
	else:
		area_detected = false


func _on_area_entered(area):
	if not "area_name" in area:
		return
	print(area.area_name)
	if area.area_name == target_area_name:
		areas.push_back(area)
	print(areas)


func _on_area_exited(area):
	if not "area_name" in area:
		return
	print(area.area_name)
	if area.area_name == target_area_name:
		var index = areas.find(area)
		if index != -1:
			areas.remove_at(index)
	print(areas)
