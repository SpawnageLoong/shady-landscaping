extends CharacterBody2D

@onready var interaction_area: InteractionArea = $interaction_area

@onready var shadow_left: Area2D = $shadow_area_left
@onready var shadow_right: Area2D = $shadow_area_right
@onready var shadow_up: Area2D = $shadow_area_up
@onready var shadow_down: Area2D = $shadow_area_down

var tile_size = 32
var animation_speed = 4
var moving = false
var target_position = [16, 16]
var tween = null
var bump_offset = 10

## Only checks directional lights
var dir_lights = {
	"left": false,
	"right": false,
	"up": false,
	"down": false
}
var lights = {
	"left": false,
	"right": false,
	"up": false,
	"down": false
}
var shadows = {
	"left": shadow_left,
	"right": shadow_right,
	"up": shadow_up,
	"down": shadow_down
}


func _process(_delta):
	update_light_directions()
	render_shadows()


func _ready():
	shadow_left.visible = true
	shadow_right.visible = true
	shadow_up.visible = true
	shadow_down.visible = true
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	print("advancing time")
	advance_time()


func advance_time():
	match GlobalVariables.global_lighting_direction:
		Vector2.LEFT:
			GlobalVariables.global_lighting_direction = Vector2.DOWN
		Vector2.DOWN:
			GlobalVariables.global_lighting_direction = Vector2.RIGHT
		Vector2.RIGHT:
			GlobalVariables.global_lighting_direction = Vector2.UP
		Vector2.UP:
			GlobalVariables.global_lighting_direction = Vector2.LEFT


func update_light_directions():
	lights = dir_lights.duplicate(true)
	match GlobalVariables.global_lighting_direction:
		Vector2.LEFT:
			lights["left"] = true
		Vector2.RIGHT:
			lights["right"] = true
		Vector2.UP:
			lights["up"] = true
		Vector2.DOWN:
			lights["down"] = true


func render_shadows():
	if lights["left"]:
		shadow_left.scale.y = 68
	else:
		shadow_left.scale.y = 0
	if lights["right"]:
		shadow_right.scale.y = 68
	else:
		shadow_right.scale.y = 0
	if lights["up"]:
		shadow_up.scale.y = 68
	else:
		shadow_up.scale.y = 0
	if lights["down"]:
		shadow_down.scale.y = 68
	else:
		shadow_down.scale.y = 0
