extends CharacterBody2D

@export var speed = 100

@onready var healthBar = $HealthBar

var health 

func _ready() -> void:
	health = 100
	healthBar.init_health(health)
	
func get_input():
	await get_tree().create_timer(1).timeout
	var input_direction = Input.get_vector("left", "right","up", "down")
	
	if input_direction == Vector2.ZERO:
		$AnimatedSprite2D.play("Idle")
		velocity = Vector2.ZERO
	else:
		$AnimatedSprite2D.play("Run")
		velocity = input_direction * speed


	
func _physics_process(delta: float) -> void:
	set_health()
	get_input()
	move_and_slide()

func set_health():
	
	healthBar.health = health
	if health <= 0:
		die()
	
func die():
	
	$AnimatedSprite2D.play("Die")
	await get_tree().create_timer(1.5)
	
