extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Velocidad = Vector2()
var distancia = Vector2()
var target
export (float) var tiempo_estimado = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node("Hasta")
	distancia = target.global_position - get_node("CuerpoPlataforma").global_position
	Velocidad = distancia / tiempo_estimado
	get_node("CuerpoPlataforma").linear_velocity = Velocidad

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_node("CuerpoPlataforma").rotation_degrees = 0

func set_objetivo():
	if(target == get_node("Desde")):
		target = get_node("Hasta")
	else:
		target = get_node("Desde")
	distancia = target.global_position - get_node("CuerpoPlataforma").global_position
	Velocidad = distancia / tiempo_estimado
	get_node("CuerpoPlataforma").linear_velocity = Velocidad


func _on_Area2D_body_entered(body):
	if(body.is_in_group("plataforma")):
		set_objetivo()
