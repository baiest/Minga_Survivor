extends Button

var next_scene = preload("res://scenes/Main.tscn")

func _pressed():
	get_tree().change_scene_to(next_scene)
