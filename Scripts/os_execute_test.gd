extends Control
@export var print_on_start := false


func _ready():
	await get_tree().create_timer(3).timeout
	if print_on_start:
		screenshot_and_print()
	pass
		# Get the user's home directory

func print_home_dir():
	var home_dir = OS.get_environment("HOME")
	# Prepare command
	var command = "ls"
	var args = [home_dir]
	var file = FileAccess.open("user://output.txt", FileAccess.WRITE)
	file.store_string("Your home dir is.\n")
	
	var output = []
	var exit_code = OS.execute(command, args, output, true)
	file.store_string("\n".join(output))
	#file.store_string("Exit code:" + exit_code)
	file.close()
	
	var output2 = []
	var exit_code2 = OS.execute("lpr", [OS.get_user_data_dir() + "/output.txt"], output2, true)
	print("Exit code:", exit_code2)
	print("Printer output:", "\n".join(output2))
	
	

func screenshot_and_print():
	# Capture the screen
	var image = get_viewport().get_texture().get_image()
	var path = OS.get_user_data_dir() + "/screenshot.png"
	image.save_png(path)
	print("Image is on: ", path)

	var output = []
	var exit_code = OS.execute("lpr", [path], output, true)
	
	print("Exit code:", exit_code)
	print("Printer output:", "\n".join(output))
