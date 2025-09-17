extends ColorRect

@onready var wContainer : WindowContainer = $"../WindowContainer"
@onready var wButton = preload("res://Scenes/window_button.tscn")

func _ready() -> void:
	populate_windows()


func populate_windows():
	for w in wContainer.get_children():
		if w is mWindow:
			var button = wButton.instantiate()
			$Container.add_child(button)
			button.name = "Pill_" + w.name
			button.text = w.name
	pass
