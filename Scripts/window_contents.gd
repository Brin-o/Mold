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
	
	# Check for [DONTFIT] tag at the very start of the file
	var has_dontfit_tag = content.begins_with("[DONTFIT]")
	# Disable RichTextLabel auto-resize when opting out
	fit_content = not has_dontfit_tag
	
	# Strip the tag from content if present
	if has_dontfit_tag:
		content = content.substr("[DONTFIT]".length())
	
	# Toggle parent window auto-fit based on tag presence
	var parent = get_parent()
	if parent and parent.has_method("set_auto_fit_height"):
		parent.set_auto_fit_height(not has_dontfit_tag)
		# Trigger appropriate sizing update
		if has_dontfit_tag:
			# When disabling auto-fit, ensure Shadow/Base is updated
			call_deferred("_trigger_parent_fit")
		else:
			# When enabling auto-fit, trigger height fitting
			if parent.has_method("fit_height"):
				parent.call_deferred("fit_height")
	
	set_window_name(text_path)
	text += content

func _trigger_parent_fit():
	var parent = get_parent()
	if parent and parent.has_method("fit_to_children"):
		parent.fit_to_children()


func try_to_add_image(image_path):
	var img_file = FileAccess.open(image_path , FileAccess.READ)
	if img_file == null:
		printerr("no image")
	else:
		#print("Adding image at the front of the text!")
		text += "[img={300}]" + image_path + "[/img]" 
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
