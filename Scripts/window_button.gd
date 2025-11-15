class_name wButton extends Button

signal btn_up (node)
var assingedWindow 




func _on_button_up() -> void:
	emit_signal("btn_up", self)


func highlight():
	set_pill_name()
	var new_stylebox_normal = get_theme_stylebox("normal").duplicate()
	new_stylebox_normal.set("bg_color", Color.BLACK)
	add_theme_color_override("font_color", Color.WHITE_SMOKE)
	print(new_stylebox_normal)
	add_theme_stylebox_override("normal", new_stylebox_normal)
	pass
	
func clear_highlight():
	set_pill_name()
	print("Removing highlight on ", text)
	remove_theme_stylebox_override("normal")
	remove_theme_color_override("font_color")
	release_focus()
	pass
	
func set_pill_name():
	if assingedWindow == null: print("no assigned window on " + name)
	if assingedWindow.get_child(0) is wTitlebar:
		var name = assingedWindow.get_child(0).get_node("Title").text
		name = name.substr(name.rfind("/") + 1)
		text = name
	pass
