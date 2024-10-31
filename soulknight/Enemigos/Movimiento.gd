extends CharacterBody2D

# Velocidad de movimiento del enemigo
var speed: float = 490.0

# Distancia mínima para atacar al jugador
var attack_distance: float = 50.0

# Referencia al nodo del jugador
@export var jugador: NodePath

# Almacena la referencia del jugador en un nodo
var jugador_ref: CharacterBody2D

func _ready():
	# Almacena la referencia del jugador usando el NodePath
	jugador_ref = get_node(jugador)
	
	# Reproduce la animación de "moverse" al iniciar la escena
	$AnimatedSprite2D.play("moverse")

	# Conectar la señal de área correctamente
	$Area2D.body_entered.connect(_on_area_2d_body_entered)

func _process(delta):
	# Lógica de seguimiento al jugador
	if jugador_ref:
		var direccion = (jugador_ref.global_position - global_position).normalized()
		var distancia = jugador_ref.global_position.distance_to(global_position)
		
		if distancia > attack_distance:
			velocity = direccion * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO  # Detenerse al estar cerca del jugador

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	# Verifica si el cuerpo que entró es el héroe
	if body.name == "Heroe":  # Asegúrate de que el nombre sea correcto
		body.recibir_dano(10)  # Llama al método para reducir la salud del héroe
