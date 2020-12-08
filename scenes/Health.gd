extends Control

var hearts  = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var Label = $Label

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	
func set_max_hearts(value):
	max_hearts = max(value, 1)

func _ready():
	self.max_hearts = 4
	self.hearts = 4
	
