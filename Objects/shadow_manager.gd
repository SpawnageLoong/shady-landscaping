extends Node2D

@onready var shadow_left: Area2D = $shadow_area_left
@onready var shadow_right: Area2D = $shadow_area_right

var shadows_enabled: bool = true

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
	"right": shadow_right
}


func _ready():
	shadow_left.visible = shadows_enabled
	shadow_right.visible = shadows_enabled


func _process(_delta):
	if shadows_enabled:
		update_light_directions()
		render_shadows()


func enable():
	shadows_enabled = true


func disable():
	shadows_enabled = false
	shadow_left.disable()
	shadow_right.disable()


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
		shadow_left.enable()
	else:
		shadow_left.disable()
	if lights["right"]:
		shadow_right.enable()
	else:
		shadow_right.disable()
