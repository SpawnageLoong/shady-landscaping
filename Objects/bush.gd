extends StaticBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var interaction_collision_area: CollisionShape2D = $interaction_area/CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shadows: Node2D = $shadow_manager
@onready var sound: AudioStreamPlayer = $AudioStreamPlayer

var is_burning: bool = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	sprite.play("idle")


func _on_interact():
	if PlayerVariables.player_potion == "fire_potion":
		print("burning")
		burn()
	else:
		print("no fire potion")


func burn():
	sound.play()
	PlayerVariables.player_potion = null
	is_burning = true
	sprite.play("burning")


func _on_animated_sprite_2d_animation_finished():
	if is_burning:
		self.queue_free()
