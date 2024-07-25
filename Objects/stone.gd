extends CharacterBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var ray: RayCast2D = $RayCast2D
@onready var push_sfx: AudioStreamPlayer = $push_sfx
@onready var shadows: Node2D = $shadow_manager

var tile_size = 32
var animation_speed = 4
var moving = false
var target_position = [16, 16]
var tween = null
var bump_offset = 10


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	print("pushing rock")
	move(PlayerVariables.player_direction)


func move(push_direction):
	if moving:
		tween.kill()
		position = target_position
	ray.target_position = push_direction * tile_size
	ray.force_raycast_update()
	push_sfx.play()
	if ray.is_colliding():
		target_position = position
		var bump_position = position + push_direction * bump_offset
		tween = create_tween()
		tween.tween_property(self, "position", bump_position, 0.5/animation_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		moving = true
		await tween.finished
		tween = create_tween()
		tween.tween_property(self, "position", target_position, 0.5/animation_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		await tween.finished
		moving = false
	else:
		target_position = position + push_direction * tile_size
		tween = create_tween()
		tween.tween_property(self, "position", target_position, 1.0/animation_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		moving = true
		await tween.finished
		moving = false
