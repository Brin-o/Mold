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
	# Enable fit_content so RichTextLabel resizes to fit the image
	fit_content = true
	
	# Set a minimum width for the RichTextLabel to accommodate the 400px image
	# Account for content margins (left + right = 20px total from StyleBoxEmpty)
	# So we need at least 400 + 20 = 420px for the RichTextLabel
	var image_width = 400
	var min_width = image_width + 20  # 400px image + 20px margins (10px each side)
	custom_minimum_size.x = min_width
	size.x = min_width
	
	# Check if the image resource exists (works in both editor and exported builds)
	if not ResourceLoader.exists(image_path):
		printerr("Image resource does not exist: ", image_path)
		# Try fallback: maybe it's a file path that needs to be loaded differently
		var image := Image.load_from_file(image_path)
		if image != null:
			# If we can load it as a file, create a texture and add it manually
			var image_texture := ImageTexture.create_from_image(image)
			if image_texture != null:
				# For RichTextLabel, we can't directly add textures via BBCode in this way
				# So we'll use the file path approach
				# BBCode syntax: [img=width]path[/img] or [img=widthxheight]path[/img]
				text += "[img=" + str(image_width) + "]" + image_path + "[/img]"
				text += "\n"
				set_window_name(image_path)
				# Wait for RichTextLabel to process the image, then resize window
				call_deferred("_fit_window_to_image")
				return
		return
	
	# Resource exists - use it directly in BBCode (works in exported builds)
	# RichTextLabel's [img] tag can load resources by path
	# BBCode syntax: [img=width]path[/img] - no curly braces!
	text += "[img=" + str(image_width) + "]" + image_path + "[/img]"
	text += "\n"
	set_window_name(image_path)
	# Wait for RichTextLabel to process the image, then resize window
	call_deferred("_fit_window_to_image")
	pass

func _fit_window_to_image():
	# Wait a couple frames to ensure RichTextLabel has fully processed the image
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Force RichTextLabel to recalculate its size
	queue_redraw()
	
	# Get the parent window and fit it to the content
	var parent = get_parent()
	if parent and parent is window_parent:
		# Enable auto-fit height if it's not already enabled
		if parent.has_method("set_auto_fit_height"):
			parent.set_auto_fit_height(true)
		
		# Ensure the Contents node (this RichTextLabel) has the right size
		# The RichTextLabel should now have the correct minimum size
		var min_size = get_minimum_size()
		if min_size.x > 0:
			size.x = max(size.x, min_size.x)
		if min_size.y > 0:
			size.y = max(size.y, min_size.y)
		
		# Fit the window to its children (which includes this RichTextLabel)
		if parent.has_method("fit_to_children"):
			parent.fit_to_children()
		# Also try fit_height which handles the Contents node specifically
		if parent.has_method("fit_height"):
			parent.fit_height()
		
		# Force another update after fitting
		await get_tree().process_frame
		if parent.has_method("fit_to_children"):
			parent.fit_to_children()
	
	
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
