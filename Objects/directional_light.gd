extends StaticBody2D

@onready var ray = $RayCast2D

var light_direction: Vector2 = Vector2.DOWN


func _process(_delta):
	var lit_object

func _on_interact():
	print("rotating light")
	ray.rotate(PI / 2)
