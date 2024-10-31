extends CharacterBody2D
func _ready():
	# Reproduce la animación de "moverse" al iniciar la escena
	$AnimatedSprite2D.play("moverse")
