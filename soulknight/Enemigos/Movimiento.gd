class_name Enemy extends CharacterBody2D

var move_speed := 50
var attack_damage := 10
var is_attack := false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var heroe: Node2D = $Heroe

func _physics_process(delta: float) -> void:
	if !is_attack and heroe:
		print("existe el heroe")
		var move_direction = (heroe.position - position).normalized()
		if move_direction:
			velocity = move_direction * move_speed
		move_and_slide() 
func attack():
	is_attack = true
	heroe.healt_component.receive_damage(attack_damage)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Heroe:
		is_attack = true
		attack()
func _on_area_2d_body_exited(body: Node2D) -> void:
	attack()

#var speed: float = 490.0
## Referencia al nodo del jugador
#@export var jugador: NodePath
#
## Almacena la referencia del jugador en un nodo
#var jugador_ref: CharacterBody2D
#
#func _ready():
	## Almacena la referencia del jugador usando el NodePath
	#jugador_ref = get_node(jugador)
	#
	## Reproduce la animación de "moverse" al iniciar la escena
	#$AnimatedSprite2D.play("moverse")
#
	## Conectar la señal de área correctamente
	#$Area2D.body_entered.connect(_on_area_2d_body_entered)
#
#func _process(delta):
	## Lógica de seguimiento al jugador
	#if jugador_ref:
		#var direccion = (jugador_ref.global_position - global_position).normalized()
		#var distancia = jugador_ref.global_position.distance_to(global_position)
		#
		## Cambiar dirección del esqueleto según la posición del héroe
		#if direccion.x < 0:
			#$AnimatedSprite2D.scale.x = -1  # Mirar a la izquierda
		#else:
			#$AnimatedSprite2D.scale.x = 1   # Mirar a la derecha
#
		#if distancia > attack_distance:
			#velocity = direccion * speed
			#move_and_slide()
		#else:
			#velocity = Vector2.ZERO  # Detenerse al estar cerca del jugador
#
#func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	## Verifica si el cuerpo que entró es el héroe
	#if body.name == "Heroe":  # Asegúrate de que el nombre sea correcto
		#body.recibir_dano(5)  # Llama al método para reducir la salud del héroe
