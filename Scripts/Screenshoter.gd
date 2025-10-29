extends Node

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		take_screenshot()

func take_screenshot():
	var img = get_viewport().get_texture().get_image()
	var timestamp = Time.get_datetime_string_from_system().replace(":", "-")
	var filename = "user://screenshot_" + timestamp + ".png"
	img.save_png(filename)
	print("Screenshot saved: ", filename)
