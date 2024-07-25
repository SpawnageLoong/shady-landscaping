extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shadow_detector: Node2D = $shadow_detector
@onready var interaction_area: InteractionArea = $interaction_area
@onready var interaction_collision_shape: CollisionShape2D = $interaction_area/CollisionShape2D
@onready var shadows: Node2D = $shadow_manager

var is_open: bool = true


func _process(_delta):
	if shadow_detector.in_shadow:
		if is_open:
			is_open = false
			interaction_collision_shape.disabled = true
			sprite.play("shrink")
	else:
		if !is_open:
			is_open = true
			sprite.play("grow")
			interaction_collision_shape.disabled = false


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	is_open = true
	sprite.play("idle")


func _on_interact():
	if PlayerVariables.player_material == null:
		print("picking up fire flower")
		pickup()
	else:
		print("materials full")


func pickup():
	PlayerVariables.player_material = "fire_flower"
	self.queue_free()


func _on_animated_sprite_2d_animation_finished():
	if is_open:
		sprite.play("idle")
		shadows.enable()
	else:
		shadows.disable()
