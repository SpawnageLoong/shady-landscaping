extends Node2D

@export var level_name = "Demo Level"

@onready var lamp = $dir_lamp
@onready var player = $player


func _ready():
	GlobalVariables.current_level = self.level_name
	GlobalVariables.level_path_name = self.name
	print("loaded ", GlobalVariables.current_level)
	PlayerVariables.has_water = false
	PlayerVariables.player_material = null
	PlayerVariables.player_potion = null
	GlobalVariables.in_demo_mode = true
	
	GlobalVariables.global_lighting_direction = Vector2.RIGHT
	lamp.is_ignited = true
	lamp.sprite.play("idle_lit")
	lamp.lamp_direction = "right"
	lamp.ray.rotation_degrees = -90
	while true:
		await player_loop()


func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout


func player_loop():
	await wait(randf_range(0.75, 1.1))
	player.move("move_down")
	await wait(randf_range(0.75, 1.1))
	InteractionManager.interact()
	await wait(randf_range(0.75, 1.1))
	player.move("move_down")
	await wait(randf_range(0.75, 1.1))
	player.move("move_right")
	await wait(randf_range(0.75, 1.1))
	player.move("move_right")
	await wait(randf_range(0.75, 1.1))
	player.move("move_left")
	await wait(randf_range(0.75, 1.1))
	player.move("move_left")
	await wait(randf_range(0.75, 1.1))
	player.move("move_down")
	await wait(randf_range(0.75, 1.1))
	player.move("move_down")
	await wait(randf_range(0.75, 1.1))
	player.move("move_right")
	await wait(randf_range(0.75, 1.1))
	player.move("move_up")
	await wait(randf_range(0.75, 1.1))
	InteractionManager.interact()
	await wait(randf_range(0.75, 1.1))
	player.move("move_up")
	await wait(randf_range(0.75, 1.1))
	player.move("move_up")
	await wait(randf_range(0.75, 1.1))
	player.move("move_left")
	await wait(randf_range(0.75, 1.1))
	player.move("move_up")
	await wait(randf_range(0.75, 1.1))
	player.move("move_up")
	await wait(randf_range(0.75, 1.1))
	player.move("move_right")
