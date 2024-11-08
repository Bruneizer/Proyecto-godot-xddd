class_name Heroe
extends CharacterBody2D

var move_speed: float = 100
var is_attacking: bool = false
var attack_duration: float = 0.5  # Duración de la animación de ataque
var attack_timer: float = 0.0  # Temporizador para controlar el ataque

var sprint_speed: float = 800.0  # Velocidad de sprint

@onready var health_component: Node2D = $Node/HealthComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D  # Nodo de animación

# Velocidad de movimiento
var speed: float = 500.0

func get_input_direction() -> Vector2:
	var input_direction = Vector2()

	if Input.is_action_pressed("ui_up"):   # W
		input_direction.y -= 1
	if Input.is_action_pressed("ui_down"): # S
		input_direction.y += 1
	if Input.is_action_pressed("ui_left"): # A
		input_direction.x -= 1
	if Input.is_action_pressed("ui_right"): # D
		input_direction.x += 1

	return input_direction.normalized()

func _physics_process(delta: float) -> void:
	# Lógica de ataque
	if is_attacking:
		attack_timer -= delta  # Reduce el temporizador
		if attack_timer <= 0:  # Si el temporizador llega a 0, permite otro ataque
			is_attacking = false
			# Reproduce la animación de descanso después del ataque
			if animated_sprite_2d.animation != "Descanso":
				animated_sprite_2d.play("Descanso")

	var direction = get_input_direction()

	if direction != Vector2.ZERO:
		# Detectar si se está presionando la tecla de sprint
		if Input.is_action_pressed("sprint"):
			velocity = direction * sprint_speed
		else:
			velocity = direction * speed
		move_and_slide()

		# Reproduce la animación de caminar si el personaje se está moviendo
		if animated_sprite_2d.animation != "Caminar":
			animated_sprite_2d.play("Caminar")

		# Orientar el sprite hacia la dirección de movimiento
		if direction.x != 0:
			animated_sprite_2d.flip_h = direction.x < 0  # Voltea hacia la izquierda si x es negativa
	else:
		velocity = Vector2.ZERO
		# Reproduce la animación de descanso si el personaje está quieto
		if animated_sprite_2d.animation != "Descanso" and not is_attacking:
			animated_sprite_2d.play("Descanso")

	# Lógica de ataque
	if Input.is_action_just_pressed("atacar") and not is_attacking:
		attack()

func attack() -> void:
	is_attacking = true  # Marca que el héroe está atacando
	animated_sprite_2d.play("Atacar")  # Reproduce la animación de ataque
	attack_timer = attack_duration  # Reinicia el temporizador del ataque
	print("Atacando!")  # Imprimir para depuración
