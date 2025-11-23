class_name window_ls extends window_parent
	

func load_ls(folder_path):
	$WindowBG/ScrollContainer/GridContainer.remove_all_icons()
	$WindowBG/ScrollContainer/GridContainer.add_folders(folder_path)
	$WindowBG/ScrollContainer/GridContainer.add_folder_files(folder_path)
	set_window_name(folder_path)
	pass


func set_window_name(file_path : String):
	var path := file_path
	var parts := path.split("Texts/")
	print(parts)
	if parts.size() > 1:
		var result = "ROOT/" + parts[1]
		$Titlebar.set_titlebar_label(result)
	pass
