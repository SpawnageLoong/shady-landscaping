extends ColorRect

@export var next_scene_path: String = ""

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var in_transition: bool = false


func transition_to(path):
	next_scene_path = path
	anim_player.play("fade")


func _on_animation_player_animation_finished(_anim_name):
	if !in_transition:
		in_transition = true
		get_tree().change_scene_to_file(next_scene_path)
		anim_player.play_backwards("fade")
	else:
		in_transition = false
