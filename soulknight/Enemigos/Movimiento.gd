extends CharacterBody2D

const Orc_run = 70

var hero: Node2D  # Referencia al héroe
var chase_distance: float = 10.0  # Distancia de persecución

func _ready():
	# Inicializa la dirección del movimiento (hacia la derecha en este caso)
	velocity.x = Orc_run
	$AnimatedSprite2D.play("moverse")
	hero = get_node("/root/Path/To/Hero")  # Asegúrate de ajustar la ruta al nodo del héroe

func _physics_process(delta):
	# Comprobar la distancia al héroe
	if hero:
		var distance_to_hero = position.distance_to(hero.position)
		print("Distancia al héroe: ", distance_to_hero)
		if distance_to_hero < chase_distance:
			# Perseguir al héroe
			velocity = (hero.position - position).normalized() * Orc_run
		else:
			# Comportamiento normal
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
