extends CharacterBody2D

@export var speed = 100

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
	get_input()
	move_and_slide()
