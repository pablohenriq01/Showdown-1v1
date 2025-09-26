extends ProgressBar

@onready var damage_bar = $DamageBar

var max_health : int


func init_health(health: int) -> void:
	max_health = health
	value = max_health
	damage_bar.value = max_health

func set_health(damage: float) -> void:
	value -= damage
	await get_tree().create_timer(0.3).timeout
	damage_bar.value -= damage