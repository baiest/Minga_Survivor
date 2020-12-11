extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
var Gravedad = 2500
var Velocidad = Vector2()
var correr = 10000
onready var player = get_parent().get_node("Player")
var distancia = 600
var movcont = 0
var ataque = true

onready var dist = 0
onready var dir = 0
func _ready():
	pass # Replace with function body.

#Animacion del enemigo de espera y ataque cuando se acerque el jugador
func animacion():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	Velocidad.y += Gravedad * delta
	
	dist = player.global_position.distance_to($AtacarJefe.global_position)
	dir = player.global_position.x - $AtacarJefe.global_position.x
	
#Esto hace que el sprite del enemigo se gire en horizontal para que mire hacia el player
	if player.position.x > position.x:
		get_node("AtacarJefe").set_flip_h(true)
	else:
		get_node("AtacarJefe").set_flip_h(false)
	
	
	if dist<distancia: 
		$AtacarJefe.play("atacar")
		$AtaqueJefeAudio.play()
		
		if ataque:
		#	$PrimerSalto.play("salto")
			ataque = false
		
		movcont = dir
		Velocidad.x = movcont
	else:
		$AtacarJefe.play("esperar")
		
		#movcont = 0
	
	#Cambio de colision
	if $AtacarJefe.frame == 2:
		$NormalJefe.disabled =true
		$CollisionAtaqueJefe.disabled = false
	else:
		$NormalJefe.disabled =false
		$CollisionAtaqueJefe.disabled = true


	#move_and_slide(Vector2(movcont, 0).normalized() * correr * delta)
	Velocidad = move_and_slide(Velocidad, Vector2(0,0))
	
