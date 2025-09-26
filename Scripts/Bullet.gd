extends CharacterBody2D

var pos:Vector2
var rota : float
var dir : float
var speed = 800
var damage_received : float

func _ready():
	
	global_position=pos
	global_rotation=rota
	
func _physics_process(delta):
	velocity= Vector2(speed,0).rotated(dir)
	move_and_slide()

func get_damage(damage: float):
	damage_received = damage

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("Player"):
		var p = area.get_parent()
		p.healthBar.set_health(damage_received)
		queue_free()
