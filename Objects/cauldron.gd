extends StaticBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var shadows: Node2D = $shadow_manager
@onready var sound: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	print("crafting")
	craft()


func craft():
	print("Before crafting:")
	print("has_water: ", PlayerVariables.has_water)
	print("material: ", PlayerVariables.player_material)
	print("potion: ", PlayerVariables.player_potion)
	if !PlayerVariables.player_material:
		return
	if !PlayerVariables.has_water:
		return
	if PlayerVariables.player_material == "fire_flower":
		sound.play()
		PlayerVariables.player_potion = "fire_potion"
		PlayerVariables.has_water = false
		PlayerVariables.player_material = null
	elif PlayerVariables.player_material == "ice_flower":
		sound.play()
		PlayerVariables.player_potion = "ice_potion"
		PlayerVariables.has_water = false
		PlayerVariables.player_material = null
	print("After crafting:")
	print("has_water: ", PlayerVariables.has_water)
	print("material: ", PlayerVariables.player_material)
	print("potion: ", PlayerVariables.player_potion)
