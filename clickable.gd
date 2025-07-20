extends Control

@export var target_node : Control

var mouse_is_in = false
func _on_mouse_entered() -> void:
	print("mouse in!!!")
	mouse_is_in = true

func _on_mouse_exited() -> void: 
	mouse_is_in = false
	
func _process(delta: float) -> void:
	if mouse_is_in and Input.is_action_just_pressed("l_click"):
		%Prompt.text_display("test")
		pass
