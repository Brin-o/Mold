class_name wButton extends Button

signal btn_up (node)
var assingedWindow : mWindow




func _on_button_up() -> void:
	emit_signal("btn_up", self)
