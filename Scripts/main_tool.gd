# save_delete_tool.gd
@tool
extends Node

# Path to the save file
const SAVE_FILE_PATH := "user://savegame.cfg"
@export_tool_button("Delete Save") var hello_action = delete_save_file
@export_tool_button("Print Save Path") var print = print_path
func _ready():
	# Check if running in the editor (tool scripts run in editor too)
	if Engine.is_editor_hint():
		print("Tool script loaded in editor.")

# Function to delete the file
func delete_save_file():
	var file = FileAccess
	if file.file_exists(SAVE_FILE_PATH):
		var err = file.remove(SAVE_FILE_PATH)
		if err == OK:
			print("Save file deleted successfully.")
		else:
			printerr("Failed to delete save file. Error code: ", err)
	else:
		print("Save file does not exist.")
		
func print_path():
	var absolute_path = ProjectSettings.globalize_path(SAVE_FILE_PATH)
	print("Absolute path to save file: ", absolute_path)
