extends Node
class_name Gun

@export_category("Gun Settings")
@export var gun_offset_x: float = 20.0
@export var gun_offset_y: float = 0.0

func _ready() -> void:

	adjust_offset()

	pass 


func _process(delta: float) -> void:
	pass

func adjust_offset() -> void:
	var gun_sprite = get_node("Sprite2D") as Sprite2D
	gun_sprite.offset = Vector2(gun_offset_x, gun_offset_y)