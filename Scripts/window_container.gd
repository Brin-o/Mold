class_name WindowContainer extends Control


func _ready():
	gather_click_singals()
	
func move_window_to_top(window):
	move_child(window, get_child_count())
	for i in get_child_count():
		get_child(i).z_index = i

	print("click from ", window.name)
	pass


func gather_click_singals():
	for w in get_children():
		if w is mWindow:
			w.click.connect(move_window_to_top)
			

func minimize_or_restore_window(window):
	if window.visible == false:
		restore_window(window)
	else:
		minimize_window(window)
func restore_window(window):
	pass
	
func minimize_window(window):
	pass
