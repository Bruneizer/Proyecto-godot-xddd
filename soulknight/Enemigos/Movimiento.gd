extends CharacterBody2D

const OrcoRun = 70

func _ready():
	velocity.x = OrcoRun
	$AnimatedSprite2D.play("moverse")
	
func _physics_process(delta):
	
	if is_on_wall():
		if !$AnimatedSprite2D.flip_h:
			velocity.x = -OrcoRun
		else:
			velocity.x = OrcoRun
		
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
	move_and_slide()
