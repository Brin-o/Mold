extends RichTextLabel

const IMAGE_FORMATS = ["png", "jpg", "bmp", "jpeg"]

func _ready():
	text = ""
	#try_to_add_image()
	#text += load_text()
	pass

func load_contents(file_path:String):
	var extension = file_path.get_extension()
	if extension == "txt":
		load_text(file_path)
		pass
	elif  IMAGE_FORMATS.has(extension):
		try_to_add_image(file_path)
		pass
	else:
		printerr("INVALID FILE TYPE: " + extension+"\nOF FILE " + file_path)

func load_text(text_path):
	print("WINDOW CONTENTS")
	print("Path is: " + text_path)
	var file = FileAccess.open(text_path , FileAccess.READ)
	var content = file.get_as_text()
	set_window_name(text_path)
	text += content


func try_to_add_image(image_path):
	var img_file = FileAccess.open(image_path , FileAccess.READ)
	if img_file == null:
		printerr("no image")
	else:
		#print("Adding image at the front of the text!")
		text += "[img]" + image_path + "[/img]" 
		text += "\n"
		set_window_name(image_path)
	pass
	
func _input(event):
	if event.is_action_released("ui_accept"):
		get_tree().reload_current_scene()
		
		
func set_window_name(file_path : String):
	var path := file_path
	var parts := path.split("Texts/")
	print(parts)
	if parts.size() > 1:
		var result = "ROOT/" + parts[1]
		get_parent().set_titlebar_label(result)
	pass
