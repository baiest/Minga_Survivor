extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
var Gravedad = 2500
var Velocidad = Vector2()
var correr = 10000
onready var player = get_parent().get_node("Player")
var distancia = 300
var movcont = 0
var ataque = true

var dist = 0
var dir = 0
func _ready():
	pass # Replace with function body.

#Animacion del enemigo de espera y ataque cuando se acerque el jugador
func animacion():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	Velocidad.y += Gravedad * delta
	
	dist = player.global_position.distance_to($Atacar.global_position)
	dir = player.global_position.x - $Atacar.global_position.x
	
#Esto hace que el sprite del enemigo se gire en horizontal para que mire hacia el player
	if player.position.x > position.x:
		get_node("Atacar").set_flip_h(true)
	else:
		get_node("Atacar").set_flip_h(false)
	
	
	if dist<distancia: 
		$Atacar.play("atacar")
		if ataque:
			$PrimerSalto.play("salto")
			ataque = false
		movcont = dir 
	else:
		$Atacar.play("esperar")
	
	#Cambio de colision
	if $Atacar.frame == 2:
		$Normal.disabled =true
		$CollisionAtaque.disabled = false
	else:
		$Normal.disabled =false
		$CollisionAtaque.disabled = true
	move_and_slide(Vector2(movcont, 1).normalized() * correr * delta)
	Velocidad = move_and_slide(Velocidad, Vector2(0,-1))
	
