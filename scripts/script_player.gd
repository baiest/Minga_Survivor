extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Gravedad = 2500
var Velocidad = Vector2()
var run_speed = 500
var jump_speed = -500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_imput():
	Velocidad.x = 0
	var rigth = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_pressed("ui_up")
	var atac = Input.is_action_just_pressed("ui_atac")
	
	if is_on_floor() and jump:
		Velocidad.y = jump_speed
	if rigth:
		$Correr.scale = Vector2(0.05,0.05)
		Velocidad.x += run_speed
		$Correr.play('correr')
	elif left:
		$Correr.scale = Vector2(-0.05,0.05)
		Velocidad.x -= run_speed
		$Correr.play('correr')
	elif atac:
		$Correr.play('quieto')
		$Correr.play('ataque')
	else:
		if $Correr.animation != "ataque":
			$Correr.play('quieto')
			
	if $Correr.animation == "ataque":
		$CollisionNormal.disabled = true
		$CollisionAtaque.disabled = false
		
	else:
		$CollisionNormal.disabled = false
		$CollisionAtaque.disabled = true

# Condicion si el jugador se sale del escenario
func die(delta):
	if ($".".global_position.y > 700):
		$".".global_position = Vector2(475, 40)
	
	var collision = move_and_collide(Vector2() * delta)
	if collision:
		if collision.collider.is_in_group('enemigo') && $Correr.animation == "ataque":
			print("Mataste al enemigo ",get_parent().get_node(collision.collider.name))
			get_parent().get_node(collision.collider.name).queue_free()

		elif collision.get_collider_shape_index() == 1:
			$".".global_position = Vector2(475, 40)
			print("Moriste ",collision.get_collider_shape_index())
	

func _physics_process(delta):
	Velocidad.y += Gravedad * delta
	get_imput()
	die(delta)
	Velocidad = move_and_slide(Velocidad, Vector2(0,-1))
