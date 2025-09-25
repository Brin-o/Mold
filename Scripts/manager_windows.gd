class_name ManagerWindows extends Control


func _ready():
	gather_click_singals()
	
func move_window_to_top(window):
	move_child(window, get_child_count())
	for i in get_child_count():
		get_child(i).z_index = i*2
		if i == get_child_count()-1:
			get_child(i).get_node("Shadow").visible = true
			pass
		else:
			get_child(i).get_node("Shadow").visible = false
	print("click from ", window.name)
	pass


func gather_click_singals():
	for w in get_children():
		if w is window_parent:
			print("Connecting click from " + w.name)
			w.click.connect(move_window_to_top)	
	pass
			

func minimize_or_restore_window(window):
	if window.visible == false:
		restore_window(window)
	else:
		minimize_window(window)
func restore_window(window : Control):
	window.visible = true
	pass
	
func minimize_window(window:Control):
	window.visible=false
	pass
