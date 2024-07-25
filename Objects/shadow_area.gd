extends Area2D
class_name ShadowArea

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var area_name = "shadow"


func disable():
	sprite.visible = false
	collision.disabled = true

func enable():
	sprite.visible = true
	collision.disabled = false
