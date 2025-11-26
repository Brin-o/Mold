extends Control

@export var icon_scene : PackedScene
@export var folder_scene : PackedScene
var root_path = "res://Texts"

func _ready():
	# Check if we're in an exported build
	if OS.has_feature("standalone") or OS.has_feature("Linux"):
		print("Running in exported build - checking resource access")
	
	# Verify the root path exists by trying to open it with DirAccess
	var test_dir := DirAccess.open(root_path)
	if test_dir == null:
		printerr("Root path does not exist or cannot be accessed: ", root_path)
		printerr("This may be an export issue - ensure 'Texts' folder is included in export settings")
		return
	
	add_folders()
		#print("ENTERING FOLDER: " + folder)
		#var folder_path :String = root_path + "/" + folder
		#display_folder_files(folder_path)
	add_folder_files(root_path) #display root folder first

func add_folders(dir_path = "res://Texts", folder_parent = self):
	var dir := DirAccess.open(dir_path)
	if dir == null:
		printerr("Could not open directory: ", dir_path)
		return
	
	var folders = dir.get_directories()
	if folders.is_empty():
		print("No folders found in: ", dir_path)
	else:
		for folder: String in folders:
			print("ADDING FOLDER: " + folder)
			var target_folder = folder_scene.instantiate()
			target_folder.name = folder
			folder_parent.add_child(target_folder)
			target_folder.setup_icon(folder)
			var folder_path = dir_path + "/" + folder
			target_folder.file_path = folder_path
			add_folder_files(folder_path, target_folder)
	pass

func add_folder_files(dir_path = "res://Texts", icon_parent = self):
	var dir := DirAccess.open(dir_path)
	if dir == null:
		printerr("Could not open folder: ", dir_path)
		return
	
	var files = dir.get_files()
	if files.is_empty():
		print("No files found in: ", dir_path)
	else:
		print("Found ", files.size(), " files in: ", dir_path)
		# Track which files we've already added to avoid duplicates
		var added_files = {}
		
		for file: String in files:
			if file == ".DS_Store":
				continue
			# Handle .import files (metadata for imported resources like PNGs)
			if file.ends_with(".import"):
				var file_name = file.replace(".import", "")
				# Only add if we haven't already added the actual file
				if not added_files.has(file_name):
					added_files[file_name] = true
					print("Adding file from .import: ", file_name)
					var icon : Icon = icon_scene.instantiate()
					icon.name = file_name + "_icon"
					icon_parent.add_child(icon)
					
					icon.file_path = dir_path + "/" + file_name
					icon.setup_icon(file_name)
			else:
				# Regular file (not .import) - add it directly
				# Skip if we already added it via .import handling
				if not added_files.has(file):
					added_files[file] = true
					print("Adding file: ", file)
					var icon : Icon = icon_scene.instantiate()
					icon.name = file + "_icon"
					icon_parent.add_child(icon)
					
					icon.file_path = dir_path + "/" + file
					icon.setup_icon(file)
	pass


func remove_all_icons():
	for child in get_children():
		child.queue_free()
