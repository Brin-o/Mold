class_name mWindow extends ColorRect

enum State {RESTING, HELD}
var state = State.RESTING

var wSize : Vector2
var mPos : Vector2
var offset : Vector2
var canMove : bool

signal click (clicked_window)

func _ready():
	wSize = size
#	var win_container = get_node("../WindowContainer")
	#win_container.click.connect("move_window_to_top")
	#global_position = get_viewport().size/2
	pass


func _input(event):
	if event.is_action_pressed("l_click") and state == State.RESTING and canMove:
		click.emit(self)
		state = State.HELD
		offset = global_position - get_global_mouse_position()
		
	if event.is_action_released("l_click") and state == State.HELD:
		z_index = 1
		state = State.RESTING
		
	if event is InputEventMouseMotion and state == State.HELD:
		position = event.position + offset


func _on_close_button_up() -> void:
	queue_free()
	pass # Replace with function body.


func _on_minimize_button_up() -> void:
	visible = false


func _on_mouse_entered() -> void:
	canMove = true

func _on_mouse_exited() -> void:
	canMove = false
