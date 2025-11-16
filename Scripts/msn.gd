extends Control

var open_chat_button = load("res://Scenes/Chat/open_chat_button.tscn")

func _ready():
	var dir := DirAccess.open("res://Chats")
	if dir == null: printerr("Could not find res://Chats/ folder!"); return
	print(dir)
	for file: String in dir.get_files():
		if (file.contains(".import") == false): 
			var n = file.get_basename()
			var path = "res://Chats" + "/" + file
			var new_button = open_chat_button.instantiate()
			new_button.text = n
			new_button.chat_path = path
			$VBoxContainer.add_child(new_button)
