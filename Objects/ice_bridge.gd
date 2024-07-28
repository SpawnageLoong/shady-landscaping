extends StaticBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var interaction_collision_shape: CollisionShape2D = $interaction_area/CollisionShape2D
@onready var sound: AudioStreamPlayer = $AudioStreamPlayer

var is_frozen = false

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	if PlayerVariables.player_potion == "ice_potion":
		print("freezing bridge")
		freeze()
	elif !PlayerVariables.has_water:
		print("getting water")
		get_water()
	else:
		print("no potion")


func freeze():
	sound.play()
	sprite.visible = true
	collision_shape.disabled = true
	interaction_collision_shape.disabled = true
	PlayerVariables.player_potion = null


func get_water():
	sound.play()
	PlayerVariables.has_water = true
