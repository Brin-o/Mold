extends MenuButton


@onready var popup := get_popup()

func _ready():
	popup.id_pressed.connect(_on_menu_item_pressed)
	pass


func _on_menu_item_pressed(id):
	print("Menu item pressed with id:", id)
	match id:
		5: #wallpicker
			%ManagerWindows.open_or_focus_wallpicker()
