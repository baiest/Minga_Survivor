extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Gravedad = 2500
var Velocidad = Vector2()
var run_speed = 350
var jump_speed = -500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_imput():
	Velocidad.x = 0
	var rigth = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_pressed("ui_up")
	
	if is_on_floor() and jump:
		Velocidad.y = jump_speed
	if rigth:
		$Correr.scale = Vector2(1,1)
		Velocidad.x += run_speed
		$Correr.play('correr')
	elif left:
		$Correr.scale = Vector2(-1,1)
		Velocidad.x -= run_speed
		$Correr.play('correr')
	else:
		$Correr.stop()
	

# Condicion si el jugador se sale del escenario
func die():
	if ($".".global_position.y > 700):
		$".".global_position = Vector2(475, 40)
	

func _physics_process(delta):
	Velocidad.y += Gravedad * delta
	get_imput()
	die()
	Velocidad = move_and_slide(Velocidad, Vector2(0,-1))
	

	

