extends CharacterBody2D

const Orc_run = 70

func _ready():
	# Inicializa la dirección del movimiento (hacia la derecha en este caso)
	velocity.x = Orc_run
	$AnimatedSprite2D.play("moverse")

func _physics_process(delta):
	if is_on_wall():
		# Si está tocando una pared, cambia la dirección del movimiento
		if !$AnimatedSprite2D.flip_h:
			velocity.x = -Orc_run  # Mueve hacia la izquierda
		else:
			velocity.x = Orc_run  # Mueve hacia la derecha
			
		# Cambia el flip del sprite dependiendo de la dirección
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true  # Voltea el sprite hacia la izquierda
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = false  # Voltea el sprite hacia la derecha

	move_and_slide()
