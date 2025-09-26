extends Node2D
class_name Gun

@export_category("Gun Settings")
@export var gun_offset_x: float = 20.0
@export var gun_offset_y: float = 0.0
@export var bullet_scene: PackedScene = null
@export var firerate: float = 1.0

@export var max_ammo: int = 30
@export var reload_time: float = 2.0

@onready var cooldown: float = 1.0 / max(firerate, 0.001)
@onready var cool_down_timer: float = cooldown 
@onready var gun_sprite: Sprite2D = get_node("Sprite2D")
@onready var fire_position: Marker2D = get_node("Sprite2D/FirePosition")

@onready var current_ammo: int = max_ammo
var reloading: bool = false
var reload_timer: float = 0.0

func _ready() -> void:
	adjust_offset()

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	shoot()
	shooting_cooldown(delta)
	update_reload(delta)
	
func adjust_offset() -> void:
	if gun_sprite:
		gun_sprite.offset = Vector2(gun_offset_x, gun_offset_y)

func fire() -> void:
	if reloading:
		return
	
	if current_ammo <= 0:
		start_reload()
		return
		
	if not bullet_scene:
		print("bullet_scene null")
		return

	var bullet = bullet_scene.instantiate()

	if "dir" in bullet:
		bullet.dir = rotation
	else:
		bullet.rotation = rotation

	get_tree().current_scene.add_child(bullet) 
	bullet.global_position = fire_position.global_position

	current_ammo -= 1

	if current_ammo <= 0:
		start_reload()
	
	print("Ammo = ", current_ammo, " / ", max_ammo)

func shoot() -> void:
	if Input.is_action_pressed("ui_accept") and cool_down_timer >= cooldown:
		fire()
		cool_down_timer = 0.0

func shooting_cooldown(delta: float) -> void:
	if cool_down_timer < cooldown:
		cool_down_timer += delta
		if cool_down_timer > cooldown:
			cool_down_timer = cooldown

func start_reload() -> void:
	if reloading:
		return
	reloading = true
	reload_timer = 0.0
	print("Reloading...")

func update_reload(delta: float) -> void:
	if not reloading:
		return
	reload_timer += delta
	if reload_timer >= reload_time:
		current_ammo = max_ammo
		reloading = false
		reload_timer = 0.0
		print("Reloaded: Ammo = ", current_ammo)
