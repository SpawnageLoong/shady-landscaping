extends Node2D

@export var level_name = "Level 2-2"

@onready var lamp_1 = $lamp_linker/linked_lamp_1
@onready var lamp_2 = $lamp_linker/linked_lamp_2

func _ready():
	lamp_2.is_ignited = true
	lamp_2.sprite.play("idle_lit")
	lamp_1.lamp_direction = "up"
	lamp_1.ray.rotation_degrees = 180
	lamp_2.lamp_direction = "up"
	lamp_2.ray.rotation_degrees = 180
	GlobalVariables.current_level = self.level_name
	GlobalVariables.level_path_name = self.name
	GlobalVariables.global_lighting_direction = Vector2.RIGHT
	print("loaded ", GlobalVariables.current_level)
	PlayerVariables.has_water = false
	PlayerVariables.player_material = null
	PlayerVariables.player_potion = null
