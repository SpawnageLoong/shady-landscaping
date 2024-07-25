extends Node2D

@onready var shadow_detector: Area2D = $shadow_detection_area
@onready var light_detector: Area2D = $light_detection_area

var in_shadow: bool = false

func _process(_delta):
	if light_detector.area_detected:
		in_shadow = false
	elif shadow_detector.area_detected:
		in_shadow = true
	else:
		in_shadow = false
