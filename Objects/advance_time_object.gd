extends CharacterBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sound: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	print("advancing time")
	advance_time()


func advance_time():
	sound.play()
	match GlobalVariables.global_lighting_direction:
		Vector2.LEFT:
			GlobalVariables.global_lighting_direction = Vector2.RIGHT
		Vector2.RIGHT:
			GlobalVariables.global_lighting_direction = Vector2.LEFT
