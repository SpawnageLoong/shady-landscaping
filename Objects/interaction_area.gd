extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"


var interact: Callable = func():
	pass


func _on_area_entered(area):
	if area.player:
		InteractionManager.register_area(self)


func _on_area_exited(area):
	if area.player:
		InteractionManager.unregister_area(self)
