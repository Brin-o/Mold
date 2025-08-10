extends ColorRect

enum State {RESTING, HELD}
var state = State.RESTING

var wSize : Vector2
var mPos : Vector2
var offset : Vector2

func _ready():
	wSize = size
	global_position = get_viewport().size/2
	pass

func _input(event):
	if event.is_action_pressed("l_click") and state == State.RESTING:
		state = State.HELD
		offset = global_position - get_global_mouse_position()
		
	if event.is_action_released("l_click") and state == State.HELD:
		state = State.RESTING
		
	if event is InputEventMouseMotion and state == State.HELD:
		print("Mouse Motion at: ", event.position)
		position = event.position + offset
