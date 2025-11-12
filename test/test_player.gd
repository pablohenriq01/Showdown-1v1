extends GdUnitTestSuite

# Garante que a cena do player é carregada apenas uma vez.
const PLAYER_SCENE := preload("res://Prefabs/Players/player1.tscn")

var player: CharacterBody2D


func before_test() -> void:
	# 1. Instancia o player.
	player = PLAYER_SCENE.instantiate()
	# 2. Adiciona o player à árvore de cena (isso aciona a chamada ao _ready() automaticamente).
	add_child(player)
	# 3. Espera o próximo frame para garantir que o _ready() foi executado e o nó está pronto.
	await get_tree().process_frame


func after_test() -> void:
	# Remove o player da árvore e o libera.
	player.queue_free()
	# Espera um frame para garantir que a liberação do nó foi processada antes do próximo teste.
	await get_tree().process_frame


func test_initial_health() -> void:
	# Testa a vida inicial (supondo que 'health' seja inicializado no _ready() do Player.gd).
	assert_int(player.health).is_equal(100)


func test_take_damage() -> void:
	# Simula a perda de vida (assumindo que 'set_health' subtrai o valor passado da vida atual).
	# Se 'set_health' for 'player.health -= damage_amount', você deve passar o valor do dano, não o valor final.
	# Vou manter sua lógica atual, mas você pode precisar ajustá-la dependendo de como 'set_health' está implementado.
	
	# ⚠️ SE 'set_health' significa 'aplicar dano': use player.set_health(20) se 20 for o dano.
	# ⚠️ SE 'set_health' significa 'setar vida para': sua lógica está correta, mas a nomenclatura confunde.
	
	# Assumindo que você quer 'Aplicar Dano de 20':
	player.take_damage(20) # Melhor prática se for aplicar dano
	assert_int(player.health).is_equal(80) 
	# Se você não tem 'take_damage', use:
	# player.health -= 20
	# assert_int(player.health).is_equal(80)


func test_die_triggers_animation() -> void:
	player.health = 0
	# Aguarda a conclusão da função 'die()' (que é uma função 'async' ou 'yield' no seu Player.gd)
	await player.die()

	var anim = player.get_node("AnimatedSprite2D")
	assert_str(anim.animation).is_equal("Die")


func test_get_input_moves_player() -> void:
	# Configurar mapeamento de entrada se o player.gd precisar disso
	player.left = "ui_left"
	player.right = "ui_right"
	player.up = "ui_up"
	player.down = "ui_down"

	Input.action_press("ui_right")
	# Garante que a função de entrada é processada.
	await player.get_input()

	var anim = player.get_node("AnimatedSprite2D")
	assert_vector(player.velocity).is_not_equal(Vector2.ZERO)
	assert_str(anim.animation).is_equal("Run")

	Input.action_release("ui_right")


func test_idle_animation_without_input() -> void:
	player.left = "ui_left"
	player.right = "ui_right"
	player.up = "ui_up"
	player.down = "ui_down"

	# Garante que a função de entrada é processada sem inputs pressionados.
	await player.get_input()

	var anim = player.get_node("AnimatedSprite2D")
	assert_vector(player.velocity).is_equal(Vector2.ZERO)
	assert_str(anim.animation).is_equal("Idle")


func test_flip_horizontal_changes_direction() -> void:
	player.left = "ui_left"
	player.right = "ui_right"
	player.up = "ui_up"
	player.down = "ui_down"

	var anim = player.get_node("AnimatedSprite2D")

	# Testa Movimento para Direita
	Input.action_press("ui_right")
	await player.get_input()
	assert_bool(anim.flip_h).is_false() # Não deve estar virado
	Input.action_release("ui_right")

	# Testa Movimento para Esquerda
	Input.action_press("ui_left")
	await player.get_input()
	assert_bool(anim.flip_h).is_true() # Deve estar virado
	Input.action_release("ui_left")
