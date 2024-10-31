extends CharacterBody2D

# Velocidad de movimiento
var speed: float = 500.0

func get_input_direction() -> Vector2:
	var input_direction = Vector2()

	# Detectar entradas de teclado
	if Input.is_action_pressed("ui_up"):   # W
		input_direction.y -= 1
	if Input.is_action_pressed("ui_down"): # S
		input_direction.y += 1
	if Input.is_action_pressed("ui_left"): # A
		input_direction.x -= 1
	if Input.is_action_pressed("ui_right"): # D
		input_direction.x += 1

	return input_direction.normalized()

func _process(_delta: float) -> void:
	var direction = get_input_direction()

	# Movimiento
	if direction != Vector2.ZERO:
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
# En el script del héroe
# En el script del héroe
var salud: int = 100  # Salud inicial

func recibir_dano(dano: int):
	salud -= dano
	print("¡El héroe ha recibido daño! Salud restante: ", salud)

	# Aquí puedes añadir lógica para manejar la muerte del héroe
	if salud <= 0:
		print("El héroe ha caído!")
		
		
	
