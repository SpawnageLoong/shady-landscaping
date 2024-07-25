extends CharacterBody2D

@onready var ray = $RayCast2D
@onready var interact_area = $player_interaction_area
@onready var move_sfx = $move_sfx
@onready var sprite = $AnimatedSprite2D

var tile_size = 32
var inputs = {
	"move_left": Vector2.LEFT, 
	"move_right": Vector2.RIGHT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}
var rotations = {
	"move_left": 90.0, 
	"move_right": -90.0,
	"move_up": 180.0,
	"move_down": 0.0
}
var idle_animations = {
	"move_left": "idle_left", 
	"move_right": "idle_right",
	"move_up": "idle_up",
	"move_down": "idle_down"
}
var animation_speed = 4
var moving = false
var target_position = [16, 16]
var tween = null
var bump_offset = 10
var step_frame = 0


func _ready():
	## position = position.snapped(Vector2.ONE * tile_size)
	## position += Vector2.ONE * tile_size/2
	target_position = position
	PlayerVariables.player_direction = Vector2.DOWN
	sprite.play("idle_down")


func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	PlayerVariables.player_direction = inputs[dir]
	interact_area.rotation_degrees = rotations[dir]
	if moving:
		tween.kill()
		position = target_position
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	move_sfx.pitch_scale = randf_range(0.95, 1.05)
	move_sfx.play()
	if ray.is_colliding():
		target_position = position
		var bump_position = position + inputs[dir] * bump_offset
		sprite.animation = dir
		sprite.stop()
		step_frame = 1 - step_frame
		sprite.frame = step_frame
		tween = create_tween()
		tween.tween_property(self, "position", bump_position, 0.5/animation_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		moving = true
		await tween.finished
		tween = create_tween()
		tween.tween_property(self, "position", target_position, 0.5/animation_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		await tween.finished
		moving = false
		sprite.play(idle_animations[dir])
	else:
		target_position = position + inputs[dir] * tile_size
		sprite.animation = dir
		sprite.stop()
		step_frame = 1 - step_frame
		sprite.frame = step_frame
		tween = create_tween()
		tween.tween_property(self, "position", target_position, 1.0/animation_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
		moving = true
		await tween.finished
		moving = false
		sprite.play(idle_animations[dir])
		
