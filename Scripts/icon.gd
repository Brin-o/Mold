class_name Icon extends Button

var  file_path : String
enum ICONTYPE {FILE, FOLDER, APP_DECODER, APP_LOG, APP_MSN}
@export var icon_type : ICONTYPE

var icon_img = load("res://Sprites/colorscm.png")
var icon_log = load("res://Sprites/terminal.png")
var icon_decoder = load("res://Sprites/kdat_verify.png")

func setup_icon(icon_label = "IconName", file_icon = null):
	$Label.text = icon_label
	
	if icon_label.containsn("PNG") or icon_label.containsn("JPG"):
		$TextureRect.texture = icon_img
	if icon_label.containsn("LOG"):
		$TextureRect.texture = icon_log
	if icon_label.containsn("DECODER"):
		$TextureRect.texture = icon_decoder
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
	if icon_type == ICONTYPE.APP_DECODER:
		print("opening decoder")
		open_decoder()
	if icon_type == ICONTYPE.APP_LOG:
		print("opening log")
		open_log()
	if icon_type == ICONTYPE.APP_MSN:
		print("opening msn")
		open_msn()
		
		
func open_decoder():
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	if (wm != null): wm.open_or_focus_decoder()
	pass
		
func open_log():
	print("log icon function")
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	if (wm != null): wm.open_or_focus_log()
	pass

func open_msn():
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	if (wm != null): wm.open_or_focus_msn()
