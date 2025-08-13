extends RichTextLabel

func _ready():
	text = load_text()

func load_text(filename = "test"):
	var path = "res://Texts/" + filename + ".txt"
	print(path)
	var file = FileAccess.open(path , FileAccess.READ)
	var content = file.get_as_text()
	return content
	
	
func _input(event):
	if event.is_action_released("ui_accept"):
		get_tree().reload_current_scene()
