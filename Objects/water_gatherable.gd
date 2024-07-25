extends StaticBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var interaction_collision_shape: CollisionShape2D = $interaction_area/CollisionShape2D


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	if !PlayerVariables.has_water:
		print("getting water")
		get_water()


func get_water():
	PlayerVariables.has_water = true
