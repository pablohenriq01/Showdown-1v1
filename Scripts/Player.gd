extends CharacterBody2D

@export_category("Gun Stats")
@export var speed = 100
@export var health = 100

@export_category("Controls")
@export_enum("left", "left_p2")
var left: String
@export_enum("right", "right_p2")
var right: String
@export_enum("up", "up_p2")
var up: String
@export_enum("down", "down_p2")
var down: String

@onready var healthBar = $HealthBar

var alive = true

func _ready() -> void:

	healthBar.init_health(health)
	
func get_input():
	await get_tree().create_timer(1).timeout
	var input_direction = Input.get_vector(left, right, up, down)
	
	if input_direction == Vector2.ZERO and alive:
		$AnimatedSprite2D.play("Idle")
		velocity = Vector2.ZERO
	if input_direction != Vector2.ZERO and alive:
		$AnimatedSprite2D.play("Run")
		velocity = input_direction * speed

	if input_direction.x != 0:
		$AnimatedSprite2D.flip_h = input_direction.x < 0
		
func set_health(damage: float) -> void:
	health -= damage
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	die()

func die():
	if health <= 0 and alive:
		print("morreu")
		alive = false
		$AnimatedSprite2D.play("Die")
		await get_tree().create_timer(2).timeout
		queue_free()

		
		
