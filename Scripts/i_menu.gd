extends MenuButton


@onready var popup := get_popup()

func _ready():
	popup.id_pressed.connect(_on_menu_item_pressed)
	pass


func _on_menu_item_pressed(id):
	print("Menu item pressed with id:", id)
	match id:
		1: #close all windows
			%ManagerWindows.close_all_windows()
		2: #min all windows
			%ManagerWindows.min_all_windows()
		5: #wallpicker
			%ManagerWindows.open_or_focus_wallpicker()
		6: #wallpicker
			get_tree().change_scene_to_file("res://Scenes/lockscreen.tscn")
