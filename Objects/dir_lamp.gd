extends StaticBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: InteractionArea = $interaction_area
@onready var ray: RayCast2D = $RayCast2D

@onready var shadow_left: Area2D = $shadow_area_left
@onready var shadow_right: Area2D = $shadow_area_right
@onready var shadow_up: Area2D = $shadow_area_up
@onready var shadow_down: Area2D = $shadow_area_down

@onready var light_left: Area2D = $light_area_left
@onready var light_right: Area2D = $light_area_right
@onready var light_up: Area2D = $light_area_up
@onready var light_down: Area2D = $light_area_down

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

var is_ignited: bool = false
var lamp_direction: String = "left"

func _process(_delta):
	update_light_directions()
	render_shadows()
	render_directional_light()


func _ready():
	shadow_left.visible = true
	shadow_right.visible = true
	shadow_up.visible = true
	shadow_down.visible = true
	light_left.visible = true
	light_right.visible = true
	light_up.visible = true
	light_down.visible = true
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	if is_ignited:
		if PlayerVariables.player_potion == "ice_potion":
			print("extinguishing lamp")
			is_ignited = false
			sprite.play("default")
			PlayerVariables.player_potion = null
		else:
			print("rotating lamp")
			rotate_lamp()
	else:
		if PlayerVariables.player_potion == "fire_potion":
			print("igniting lamp")
			is_ignited = true
			sprite.play("idle_lit")
			PlayerVariables.player_potion = null
		else:
			print("no fire potion")


func rotate_lamp():
	if lamp_direction == "left":
		lamp_direction = "up"
		ray.rotation_degrees = 180
		return
	if lamp_direction == "up":
		lamp_direction = "right"
		ray.rotation_degrees = -90
		return
	if lamp_direction == "right":
		lamp_direction = "down"
		ray.rotation_degrees = 0
		return
	if lamp_direction == "down":
		lamp_direction = "left"
		ray.rotation_degrees = 90
		return
	print(lamp_direction)


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
	if lights["left"] and !(lamp_direction == "left" and is_ignited):
		shadow_left.scale.y = 68
	else:
		shadow_left.scale.y = 0
	if lights["right"] and !(lamp_direction == "right" and is_ignited):
		shadow_right.scale.y = 68
	else:
		shadow_right.scale.y = 0
	if lights["up"] and !(lamp_direction == "up" and is_ignited):
		shadow_up.scale.y = 68
	else:
		shadow_up.scale.y = 0
	if lights["down"] and !(lamp_direction == "down" and is_ignited):
		shadow_down.scale.y = 68
	else:
		shadow_down.scale.y = 0

func render_directional_light():
	var light_length = ray.target_position.y
	ray.force_raycast_update()
	if ray.is_colliding():
		var collision_point = ray.get_collision_point()
		var distance_vector = self.global_position - collision_point
		light_length = max(abs(distance_vector.x), abs(distance_vector.y))
	else:
		light_length = ray.target_position.y
	if !is_ignited:
		light_left.scale.y = 0
		light_right.scale.y = 0
		light_up.scale.y = 0
		light_down.scale.y = 0
		return
	if lamp_direction == "left":
		light_left.scale.y = light_length
	else:
		light_left.scale.y = 0
	if lamp_direction == "right":
		light_right.scale.y = light_length
	else:
		light_right.scale.y = 0
	if lamp_direction == "up":
		light_up.scale.y = light_length
	else:
		light_up.scale.y = 0
	if lamp_direction == "down":
		light_down.scale.y = light_length
	else:
		light_down.scale.y = 0
