class_name window_ls extends window_parent
	

func load_ls(folder_path):
	$WindowBG/GridContainer.remove_all_icons()
	$WindowBG/GridContainer.add_folders(folder_path)
	$WindowBG/GridContainer.add_folder_files(folder_path)
	pass
