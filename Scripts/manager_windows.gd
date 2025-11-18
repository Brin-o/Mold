class_name ManagerWindows extends Control


var folder_window = load("res://Scenes/window_ls.tscn")
var content_window = load("res://Scenes/window.tscn")
var decoder_window = load("res://Scenes/window_decoder.tscn")
var chatlog_window = load("res://Scenes/Chat/window_chatlog.tscn")
var msn_window = load("res://Scenes/Chat/window_msn.tscn")
var log_window = load("res://Scenes/window_log.tscn")
var form_window = load("res://Scenes/window_form.tscn")
var wallpicker_window = load("res://Scenes/window_wallpicker.tscn")
@onready var tBar : tBar = $"../TopBar"
var top_window

func _ready():
	gather_click_singals()
	
func move_window_to_top(window):
	move_child(window, get_child_count())
	for i in get_child_count():
		get_child(i).z_index = i*2
		get_child(i)
		if i == get_child_count()-1:
			#TOP WINDOW
			get_child(i).get_node("Shadow").visible = true
			get_child(i).get_node("Titlebar").assignedPill.highlight()
			top_window = window
		else:
			#NON TOP WINDOW
			get_child(i).get_node("Titlebar").assignedPill.clear_highlight()
			get_child(i).get_node("Shadow").visible = false
	pass

func clear_top_window():
	top_window = null
	for i in get_child_count():
		get_child(i).z_index = i*2
		get_child(i)
		get_child(i).get_node("Titlebar").assignedPill.clear_highlight()
		get_child(i).get_node("Shadow").visible = false

func gather_click_singals():
	for w in get_children():
		if w is window_parent:
			if !w.click.is_connected(move_window_to_top):
				w.click.connect(move_window_to_top)	
	pass
			

func minimize_or_restore_window(window):
	if window.visible == false:
		restore_window(window)
	else:
		minimize_window(window)
func restore_window(window : Control):
	window.visible = true
	pass
	
func minimize_window(window:Control):
	window.visible=false
	clear_top_window()
	pass
	
func create_new_folder_window(folder_path):
	var new_folder_window : window_ls = folder_window.instantiate()
	add_child(new_folder_window)
	new_folder_window.load_ls(folder_path)
	gather_click_singals()
	tBar.populate_windows()
	move_window_to_top(new_folder_window)
	new_folder_window.center_to_screen()
	pass
	
func create_new_content_window(content_path):
	var new_content_window : window_parent = content_window.instantiate()
	add_child(new_content_window)
	new_content_window.load_content(content_path)
	gather_click_singals()
	tBar.populate_windows()
	move_window_to_top(new_content_window)
	new_content_window.fit_height()
	new_content_window.center_to_screen()
	pass
	
	
func open_or_focus_decoder():
	var decoder = get_node_or_null("Decoder")
	if(decoder == null):
		decoder = decoder_window.instantiate()
		add_child(decoder)
		gather_click_singals()
		tBar.populate_windows()
	move_window_to_top(decoder)
	decoder.center_to_screen()
	pass
	
func open_or_focus_log():
	var log_w = get_node_or_null("Log")
	if(log_w == null):
		log_w = log_window.instantiate()
		add_child(log_w)
		gather_click_singals()
		tBar.populate_windows()
	move_window_to_top(log_w)
	log_w.center_to_screen()
	pass
	
func open_chatlog(path):
	var chatlog_w      = chatlog_window.instantiate()
	var chat : ChatLog = chatlog_w.get_node("Chat")
	
	add_child(chatlog_w)
	gather_click_singals()
	tBar.populate_windows()
	move_window_to_top(chatlog_w)
	chatlog_w.center_to_screen()
	chat.load_chat(path)
	pass
	
func open_or_focus_msn():
	var msn_w = get_node_or_null("WindowMSN")
	if(msn_w == null):
		msn_w = msn_window.instantiate()
		add_child(msn_w)
		gather_click_singals()
		tBar.populate_windows()
	move_window_to_top(msn_w)
	msn_w.center_to_screen()
	pass

func open_or_focus_form():
	var form_w = get_node_or_null("WindowForm")
	if(form_w == null):
		form_w = form_window.instantiate()
		add_child(form_w)
		gather_click_singals()
		tBar.populate_windows()
	move_window_to_top(form_w)
	form_w.center_to_screen()
	pass
	

func open_or_focus_wallpicker():
	var wp_w = get_node_or_null("Wallpicker")
	if(wp_w == null):
		wp_w = wallpicker_window.instantiate()
		add_child(wp_w)
		gather_click_singals()
		tBar.populate_windows()
	move_window_to_top(wp_w)
	wp_w.center_to_screen()
	pass


func minimize_restore_or_focus_window(window):
	if(window == top_window):
		minimize_window(window)
	elif window.visible == true:
		move_window_to_top(window)
	else: #not visible not in focus
		restore_window(window)
		move_window_to_top(window)
	pass
