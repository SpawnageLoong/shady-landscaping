extends StaticBody2D

@export var next_scene = "res://UI/main_menu.tscn"

@onready var sprite: Sprite2D = $Sprite2D
@onready var interaction_area: InteractionArea = $interaction_area
@onready var shadows: Node2D = $shadow_manager


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	sprite.frame = 1
	call_deferred("change_level")


func change_level():
	SceneTransitions.transition_to(next_scene)
