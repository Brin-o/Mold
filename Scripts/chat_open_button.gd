extends Control

var chat_path = "res://Chats/tara.txt"



func _on_button_up() -> void:
	print("Opening chat: " + chat_path)
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	if (wm != null): wm.open_chatlog(chat_path)
