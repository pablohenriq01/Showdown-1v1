extends Node2D
class_name Gun

@export_category("Gun Settings")
@export var gun_offset_x: float = 20.0
@export var gun_offset_y: float = 0.0

var bullet_path=preload("res://Prefabs/Bullets/bullet_test.tscn")
func _physics_process(delta):
	
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("ui_accept"):
		fire()
func _ready() -> void:

	adjust_offset()

	pass 
func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir=rotation
	bullet.pos=$".".global_position
	get_parent().add_child(bullet)

func _process(delta: float) -> void:
	pass

func adjust_offset() -> void:
	var gun_sprite = get_node("Sprite2D") as Sprite2D
	gun_sprite.offset = Vector2(gun_offset_x, gun_offset_y)
