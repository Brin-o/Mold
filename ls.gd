extends Control

@export var icon_scene : PackedScene
@export var folder_scene : PackedScene
var root_path = "res://Texts"

func _ready():
	add_folders()
		#print("ENTERING FOLDER: " + folder)
		#var folder_path :String = root_path + "/" + folder
		#display_folder_files(folder_path)
	add_folder_files(root_path) #display root folder first

func add_folders(dir_path = "res://Texts", folder_parent = self):
	var dir := DirAccess.open(dir_path)
	for folder: String in dir.get_directories():
		print("ADDING FOLDER: " + folder)
		var target_folder = folder_scene.instantiate()
		target_folder.name = folder
		folder_parent.add_child(target_folder)
		var folder_path = dir_path + "/" + folder
		add_folder_files(folder_path, target_folder)
	pass

func add_folder_files(dir_path = "res://Texts", icon_parent = self):
	var dir := DirAccess.open(dir_path)
	if dir == null: printerr("Could not open folder"); return
	for file: String in dir.get_files():
		if (file.contains(".import") == false): 
			print("ADDING:")
			print("-> ", file)
			print("--------")
			var icon : Icon = icon_scene.instantiate()
			icon.name = file + "_icon"
			icon_parent.add_child(icon)
			icon.file_path = "res://Texts/" + file
	pass
