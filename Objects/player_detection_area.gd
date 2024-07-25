extends Area2D
class_name PlayerDetectionArea

@export var target_body_name = "player"

var body_detected = false
var bodies = []

func _process(_delta):
	if bodies.size() > 0:
		body_detected = true
	else:
		body_detected = false


func _on_body_entered(body):
	print(body.name)
	if body.name == target_body_name:
		bodies.push_back(body)
