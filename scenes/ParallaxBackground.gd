extends ParallaxBackground

export var DIR = Vector2(0,1)
export var SPEED = 100

func _physics_process(delta):
	scroll_offset -= DIR * SPEED * delta
	
	if scroll_offset.x >= 1024:
		scroll_offset.x += 1024
	if scroll_offset.y >= 640:
		scroll_offset.y -= 640
	
	set_scroll_offset(scroll_offset)

	print(scroll_offset)

