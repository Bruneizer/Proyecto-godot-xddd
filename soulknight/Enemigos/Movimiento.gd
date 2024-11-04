extends CharacterBody2D

const ESQUELETO_RUN = 70  # Velocidad de movimiento del enemigo

@onready var player: Node2D = get_node("Heroe")  # Ajusta el path según tu escena

func _physics_process(delta: float) -> void:
	if player:
		# Calcular la dirección hacia el jugador
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * ESQUELETO_RUN  # Moverse hacia el jugador
		move_and_slide()  # Aplicar el movimiento

		# Orientar el sprite hacia el jugador
		$AnimatedSprite2D.flip_h = direction.x < 0  # Voltea el sprite hacia la dirección correcta
		$AnimatedSprite2D.play("moverse")  # Reproduce la animación de movimiento
	else:
		# Si el jugador no está disponible, detener el movimiento
		velocity = Vector2.ZERO
