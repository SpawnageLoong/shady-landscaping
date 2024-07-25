extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shadow_detector: Area2D = $shadow_detection_area
@onready var shadows: Node2D = $shadow_manager

var is_grown: bool = false
var in_animation: bool = false

func _process(_delta):
	if shadow_detector.area_detected:
		if is_grown:
			is_grown = false
			in_animation = true
			sprite.play("shrink")
			collision_shape.disabled = true
	else:
		if !is_grown:
			is_grown = true
			in_animation = true
			sprite.play("grow")
			collision_shape.disabled = false


func _on_animated_sprite_2d_animation_finished():
	if !in_animation:
		return
	in_animation = false
	if is_grown:
		sprite.play("idle_big")
		shadows.enable()
	else:
		sprite.play("idle_small")
		shadows.disable()
