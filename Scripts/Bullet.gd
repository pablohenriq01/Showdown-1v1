extends CharacterBody2D

var pos:Vector2
var rota : float
var dir : float
var speed = 2000
var damage_received : float

@onready var player1 : PackedScene = preload("res://Prefabs/Players/player1.tscn")
@onready var player2 : PackedScene = preload("res://Prefabs/Players/player2.tscn")
@onready var p2 = player2.instantiate()

func _ready():
	
	global_position=pos
	global_rotation=rota
	
func _physics_process(delta):
	velocity= Vector2(speed,0).rotated(dir)
	move_and_slide()

func get_damage(damage: float):
	damage_received += damage

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("Player2"):
		p2.set_health(damage_received)
		queue_free()
