class_name ChatLog extends Control


@onready var chat_container = $MsgWindow/MarginContainer/ChatContainer
var bubble1 = load("res://Scenes/Chat/person_1.tscn")
var bubble2 = load("res://Scenes/Chat/person_2.tscn")


var texts = []

var scrollPos = 0

func _ready():

	pass
	
func load_chat(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	texts = content.split("\n")
	scrollPos = -size.y
	for t in texts:
		add_bubble(t)
		await get_tree().create_timer(0.5).timeout	
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
