extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Gravedad = 2500
var Velocidad = Vector2()
var run_speed = 500
var jump_speed = -500
var health = 3

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
		$Machetazo.play()
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
	#modificada muerte cuando cae al vacio
	if ($".".global_position.y > 700):
		$".".global_position.y -= 500
		$".".global_position.x -= 400
		if (health == 0):
			get_tree().reload_current_scene()
		else:
			get_parent().get_node("PlayerGui").get_node("Health").get_child(health-1).visible = false
		$MuertePlayer.play()
		health-=1

	#obteniendo el objeto de colision
	var collision = move_and_collide(Vector2() * delta)
	#verificar que haya colision
	if collision:
		#si coliciona un enemigo mientras se lanza el ataque, el enemigo muere
		if collision.collider.is_in_group('enemigo') && $Correr.animation == "ataque":
			#print("Mataste al enemigo ",get_parent().get_node(collision.collider.name))
			$MuerteEnemigo.play()
			get_parent().get_node(collision.collider.name).queue_free()
		#si colisiona un enemigo mietras el enemigo esta atacando morimos
		elif collision.collider.is_in_group('enemigo') && collision.get_collider_shape_index() == 1:
			if (health == 0):
				#Reinicio del nivel
				get_tree().reload_current_scene() 
			else:
				#sonido de muerte
				$MuertePlayer.play()
				#Quitar un corazon y correr al jugador
				$".".global_position.x -= 80
				get_parent().get_node("PlayerGui").get_node("Health").get_child(health-1).visible = false
				health -= 1
		#si colisiona con un rehen se desactiva el collider del rehen
		if collision.collider.is_in_group('rehenes'):
			#print("Liberaste al rehen ",collision.collider.get_node("./ColisionRehen").get_name())
			$LiberacionRehen.play()
			collision.collider.get_node("./ColisionRehen").disabled = true
			collision.collider.get_node("./Estado").play('libre')

func _physics_process(delta):
	Velocidad.y += Gravedad * delta
	get_imput()
	die(delta)
	Velocidad = move_and_slide(Velocidad, Vector2(0,-1))

