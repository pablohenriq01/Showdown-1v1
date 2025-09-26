extends Node2D
class_name GunComponent



func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	mouse_follow()

func mouse_follow():
	var mouse_pos = get_global_mouse_position()
	var parent = get_parent()
	var gun_sprite = parent.get_node("Sprite2D") as Sprite2D
	gun_sprite.look_at(mouse_pos)
	
	if parent.global_position.x < mouse_pos.x:
		gun_sprite.flip_v = false
	else:
		gun_sprite.flip_v = true
