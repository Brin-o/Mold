extends Control

func _ready():
	add_wallpapers_to_list()
	$Wallpaper/OptionButton.select(-1)
	pass
func add_wallpapers_to_list():
	var path = "res://Sprites/Wallpapers/"
	var dir := DirAccess.open("res://Sprites/Wallpapers/")
	if dir == null: printerr("Could not open folder in dir ... ", path); return
	var i = 0
	for file: String in dir.get_files():
		if (file.contains(".import") == false): 
			$Wallpaper/OptionButton.add_item(file.get_file().get_basename(), i)
			i+=1


func _on_button_button_down() -> void:
	set_wallpaper()
	pass # Replace with function body.


func set_wallpaper():
	var selected = $Wallpaper/OptionButton.selected
	var selected_wall_path = "res://Sprites/Wallpapers/" + $Wallpaper/OptionButton.get_item_text(selected) + ".png"
	print(selected_wall_path)
	var new_wallpaper = load(selected_wall_path)
	var bg_node:TextureRect = $"../../../BG"
	if(bg_node == null): print("No BG node found."); return;
	bg_node.texture = new_wallpaper
	bg_node.stretch_mode = $Mode/OptionButton.selected
	pass
