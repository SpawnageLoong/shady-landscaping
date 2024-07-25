extends StaticBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: InteractionArea = $interaction_area
@onready var ray: RayCast2D = $RayCast2D
@onready var shadows: Node2D = $shadow_manager

@onready var light_left: Area2D = $light_area_left
@onready var light_right: Area2D = $light_area_right
@onready var light_up: Area2D = $light_area_up
@onready var light_down: Area2D = $light_area_down


var is_ignited: bool = false
var lamp_direction: String = "left"

func _process(_delta):
	render_directional_light()


func _ready():
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
			get_parent().rotate_linked_lamps()
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


func render_directional_light():
	var light_length
	ray.force_raycast_update()
	if ray.is_colliding():
		var collision_point = ray.get_collision_point()
		var distance_vector = self.global_position - collision_point
		light_length = max(abs(distance_vector.x), abs(distance_vector.y))
	else:
		light_length = 480
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
