extends RichTextLabel

func _ready():
	text = ""
	try_to_add_image()
	text += load_text()
	pass
	

func load_text(filename = "test"):
	var path = "res://Texts/" + filename + ".txt"
	print(path)
	var file = FileAccess.open(path , FileAccess.READ)
	var content = file.get_as_text()
	return content

func try_to_add_image(filename = "test"):
	var path = "res://Texts/" + filename + ".png"
	var img_file = FileAccess.open(path , FileAccess.READ)
	if img_file == null:
		print("no image")
	else:
		print("Adding image at the front of the text!")
		text += "[img]" + path + "[/img]" 
		text += "\n"
	pass
	
func _input(event):
	if event.is_action_released("ui_accept"):
		get_tree().reload_current_scene()
