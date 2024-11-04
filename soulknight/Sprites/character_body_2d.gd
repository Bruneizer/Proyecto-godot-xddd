class_name Heroe
extends CharacterBody2D

var move_speed := 100
var attack_damage := 50
var is_attack := false

@onready var health_component: Node2D = $Node/HealthComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D  # Nodo de animación

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

func _physics_process(delta: float) -> void:
	var direction = get_input_direction()

	# Movimiento
	if direction != Vector2.ZERO:
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
		if animated_sprite_2d.animation != "descanso":
			animated_sprite_2d.play("descanso")
