class_name Icon extends Button

var  file_path : String
enum ICONTYPE {FILE, FOLDER}
@export var icon_type : ICONTYPE

func setup_icon(icon_label = "IconName", file_icon = null):
	$Label.text = icon_label
	pass



func open_folder():
	#print("Opening folder")
	if icon_type != ICONTYPE.FOLDER: printerr("Icon ", name, " is not of type FOLDER while"); return
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	wm.create_new_folder_window(file_path)


func open_content():
	print("Opening file – s1 ICON " + file_path)
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	if (wm != null): wm.create_new_content_window(file_path)
	pass

func _on_button_up() -> void:
	if icon_type == ICONTYPE.FOLDER:
		open_folder()
	if icon_type == ICONTYPE.FILE:
		open_content()
