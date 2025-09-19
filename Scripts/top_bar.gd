extends ColorRect

@onready var wContainer : WindowContainer = $"../WindowContainer"
@onready var wButton = preload("res://Scenes/window_button.tscn")
@onready var pContainer = $PillContainer

func _ready() -> void:
	wButton = preload("res://Scenes/window_button.tscn")
	populate_windows()


func populate_windows():
	for w in wContainer.get_children():
		if w is mWindow:
			var button : wButton = wButton.instantiate()
			pContainer.add_child(button)
			button.assingedWindow = w
			button.name = "Pill_" + w.name
			button.text = w.name
	populate_pill_connections()
	pass

func populate_pill_connections():
	for p in pContainer.get_children():
		if p is wButton:
			p.btn_up.connect(minimize_or_restore_window)
		pass
	pass


func minimize_or_restore_window(btnSender:wButton):
	#print("test")
	print("coming from ", btnSender)
	wContainer.minimize_or_restore_window(btnSender.assingedWindow)
	pass
