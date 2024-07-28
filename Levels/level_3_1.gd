extends Node2D

@export var level_name = "Level 2-2"

@onready var lamp_1 = $lamp_linker/linked_lamp_1
@onready var lamp_2 = $lamp_linker/linked_lamp_2

func _ready():
	lamp_1.is_ignited = true
	lamp_1.sprite.play("idle_lit")
	lamp_1.lamp_direction = "down"
	lamp_1.ray.rotation_degrees = 0
	GlobalVariables.current_level = self.level_name
	GlobalVariables.level_path_name = self.name
	GlobalVariables.global_lighting_direction = Vector2.LEFT
	print("loaded ", GlobalVariables.current_level)
	PlayerVariables.has_water = false
	PlayerVariables.player_material = null
	PlayerVariables.player_potion = null
