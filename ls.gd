extends Control

@export var icon_scene : PackedScene

func _ready():
	var dir := DirAccess.open("res://Texts")
	if dir == null: printerr("Could not open folder"); return
	print(dir.get_files())
	for file: String in dir.get_files():
		if (file.contains(".import") == false): 
			print("ADDING:")
			print("-> ", file)
			print("--------")
			var icon : Icon = icon_scene.instantiate()
			icon.name = file + "_icon"
			add_child(icon)
			icon.file_path = "res://Texts/" + file
			
