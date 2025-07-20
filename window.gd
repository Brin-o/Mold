extends Control

var can_be_dragged = false
var is_dragging = false;

var state = 0
var max_state = 2

func _on_mouse_entered() -> void:
	can_be_dragged = true
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	can_be_dragged = false
	pass # Replace with function body.


func _process(delta: float) -> void:
	handle_active_img()
	if can_be_dragged:
		if Input.is_action_just_pressed("l_click"):
			is_dragging = true
			
	if is_dragging:
		move_window()

func handle_active_img():
	if Input.is_action_just_pressed("l_click") and not is_dragging:
		state += 1
		if state > max_state:
			state = 0
		print("state is ", state)
		for c in get_children():
			print("INVISIBLE: ", c.name)
			c.visible = false
			pass
		var chosen = get_child(state)
		print("VISIBLE: ", chosen.name)
		chosen.visible = true
	pass

func move_window():
	var p = get_viewport().get_mouse_position() 
	%MousePos.text = str(p)
	#position = p
	if Input.is_action_just_released("l_click"):
		is_dragging = false
