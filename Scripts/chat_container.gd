class_name ChatLog extends Control


@onready var chat_container = $MsgWindow/MarginContainer/ChatContainer
var bubble1 = load("res://Scenes/Chat/person_1.tscn")
var bubble2 = load("res://Scenes/Chat/person_2.tscn")
var chat_name

var texts = []
var loaded = false

var scrollPos = 0

@onready var status_label = $Status
# --- Phase constants ---
const PHASE_COUNTDOWN = 0
const PHASE_CONNECTING = 1
const PHASE_FAILED = 2

# --- Countdown settings ---
var countdown_time := 15
var countdown_current := countdown_time

# --- Connecting animation settings ---
var connect_duration := 4.0
var connect_timer := 0.0
var dot_count := 0
var dot_interval := 0.5  # seconds between adding dots

# --- Failed animation settings ---
var failed_duration := 5.0
var failed_timer := 0.0
var blink := false
var blink_interval := 0.5
var blink_timer := 0.

# --- State tracking ---
var phase := PHASE_COUNTDOWN
var countdown_timer = 0.0
func _ready():
	pass
	
func set_chat_seen_flag(key: String, value: bool) -> void:
	var config = ConfigFile.new()
	config.load("user://savegame.cfg")  # load existing file or create new
	config.set_value("chat_seen", key, value)  # save under "seen" section
	config.save("user://savegame.cfg")    # write to disk

func get_seen_flag(key: String) -> bool:
	var config = ConfigFile.new()
	var err = config.load("user://savegame.cfg")
	if err == OK:
		return config.get_value("chat_seen", key, false)  # default false if missing
	return false

func load_chat(path):
	var file = FileAccess.open(path, FileAccess.READ)
	chat_name = path.get_file().get_basename()
	$ContactStatus/Name.text = chat_name
	set_chat_window_name(chat_name)
	loaded = get_seen_flag(chat_name)
	var content = file.get_as_text()
	texts = content.split("\n")
	scrollPos = -size.y
	
	var dot_count := 0  # Tracks number of dots
	for t in texts:
		# --- CHECK FOR [ICON:word] ---
		if t.begins_with("[ICON:"):
			var start = t.find(":")
			var end = t.find("]")
			if start != -1 and end != -1:
				var icon_name = t.substr(start + 1, end - (start + 1))
				set_pfp(icon_name)
			continue  # <-- SKIP add_bubble
		
		add_bubble(t)
		dot_count = (dot_count + 1) % 4  # cycles 0..3
		$Status.text = "Chat loading" + ".".repeat(dot_count)
		if(!loaded):
			await get_tree().create_timer(3).timeout
	$Status.text = "Can not reach [WT] ORB!"


	$TextEdit.editable = true
	set_chat_seen_flag(chat_name, true)
	pass
	
func set_pfp(name: String) -> void:
	var base_path := "res://PFPs/"
	var pfp_path := ""
	var extensions := [".png", ".webp", ".jpg", ".jpeg"]

	# Find matching file
	for ext in extensions:
		var try_path = base_path + name + ext
		if ResourceLoader.exists(try_path):
			pfp_path = try_path
			break
	# If no file found → error
	if pfp_path == "":
		printerr("PFP ERROR: No profile picture found for '" + name + "' in res://PFPs/")
		return
	# Load the texture (export-safe)
	var texture := load(pfp_path)
	if texture == null:
		printerr("PFP ERROR: Failed to load texture at: " + pfp_path)
		return
	# Assign the texture
	$ContactStatus/PFP/Icon.texture = texture
	
func set_chat_window_name(c_name):
	var titlebar : wTitlebar = $"../Titlebar"
	var name = "[WT] " + c_name
	if titlebar == null: return
	titlebar.set_titlebar_label(name)
	pass
	


func add_bubble(bubble_text : String):
	if(bubble_text == ""):
		print("Empty line skipping")
		return
	var side = bubble_text.left(2)

	var bubble =  bubble1.instantiate()
	if(side == "1:"):
		bubble = bubble1.instantiate()
	elif(side == "2:"): bubble = bubble2.instantiate()
	var text = bubble_text.right(-3)
	bubble.get_node("Label").text = text
	chat_container.get_node("VBoxContainer").add_child(bubble)
	
	scrollPos += bubble.size.y
	chat_container.scroll_vertical = max(0,scrollPos)
	pass

func get_line_count(rtl) -> int:
	# Make sure we have a valid font size
	var font_size = rtl.get_theme_font_size("normal")  # or specify your font size
	if font_size <= 0:
		font_size = 16  # fallback default

	var line_height = rtl.get_line_height(font_size)
	if line_height <= 0:
		return 0  # avoid division by zero

	var content_height = rtl.get_content_height()
	var num_lines = ceil(content_height / line_height)
	print("LINE COUNT ", num_lines)
	return num_lines
	
	
func _process(delta):
	if(!loaded): return
	match phase:
		PHASE_COUNTDOWN:
			countdown_timer += delta
			if countdown_timer >= 1.0:
				countdown_current -= 1
				countdown_timer = 0.0

			status_label.text = "Cannot reach [WT] ORB.\nReconnecting in %d" % countdown_current

			if countdown_current <= 0:
				phase = PHASE_CONNECTING
				connect_timer = 0.0
				dot_count = 0

		PHASE_CONNECTING:
			connect_timer += delta
			dot_count = int(connect_timer / dot_interval) % 4  # 0..3 dots
			status_label.text = "Connecting to WV_Talk" + ".".repeat(dot_count)

			if connect_timer >= connect_duration:
				phase = PHASE_FAILED
				failed_timer = 0.0
				blink = false
				blink_timer = 0.0

		PHASE_FAILED:
			failed_timer += delta
			blink_timer += delta
			if blink_timer >= blink_interval:
				blink = !blink
				blink_timer = 0.0

			status_label.text = "COULD NOT CONNECT" if blink else ""

			if failed_timer >= failed_duration:
				phase = PHASE_COUNTDOWN
				countdown_current = countdown_time
				countdown_timer = 0.0
