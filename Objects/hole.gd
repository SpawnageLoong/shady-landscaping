extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var carpet_detector: Area2D = $carpet_detection_area

func _process(_delta):
	if carpet_detector.area_detected:
		collision_shape.disabled = true
	else:
		collision_shape.disabled = false
