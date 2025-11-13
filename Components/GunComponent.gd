extends Node2D
class_name GunComponent



func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	mouse_follow()
	

func mouse_follow():
	var parent = get_parent()
	var gun_sprite = parent.get_node("Sprite2D") as Sprite2D
	var fire_position = $"../Sprite2D/FirePosition"
	if parent.global_position.x < fire_position.global_position.x :
		gun_sprite.flip_v = false
	else:
		gun_sprite.flip_v = true
