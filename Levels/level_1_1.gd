extends Node2D

@export var level_name = "Level 1-1"


func _ready():
	GlobalVariables.current_level = self.level_name
	GlobalVariables.level_path_name = self.name
	GlobalVariables.global_lighting_direction = Vector2.RIGHT
	print("loaded ", GlobalVariables.current_level)
	PlayerVariables.has_water = false
	PlayerVariables.player_material = null
	PlayerVariables.player_potion = null
