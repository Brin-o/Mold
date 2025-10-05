class_name tBar extends ColorRect

@onready var wContainer : ManagerWindows = $"../ManagerWindows"
@onready var wButton = preload("res://Scenes/window_button.tscn")
@onready var pContainer = $PillContainer

func _ready() -> void:
	wButton = preload("res://Scenes/window_button.tscn")
	populate_windows()


func populate_windows():
	for w in wContainer.get_children():
		if w.get_child(0) is wTitlebar:
			var button : wButton = wButton.instantiate()
			pContainer.add_child(button)
			button.assingedWindow = w
			w.get_child(0).assignedPill = button
			button.name = "Pill_" + w.get_child(0).name
			button.text = w.name
	_populate_pill_connections()
	pass

func _populate_pill_connections():
	for p in pContainer.get_children():
		if p is wButton:
			p.btn_up.connect(minimize_or_restore_window)
		pass
	pass


func minimize_or_restore_window(btnSender:wButton):
	#print("test")
	#print("coming from ", btnSender)
	wContainer.minimize_or_restore_window(btnSender.assingedWindow)
	pass
