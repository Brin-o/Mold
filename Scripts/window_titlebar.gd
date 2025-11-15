class_name wTitlebar extends ColorRect

enum State {RESTING, HELD}
var state = State.RESTING

var wSize : Vector2
var mPos : Vector2
var offset : Vector2
var canMove : bool
@onready var whole_window : Control = get_parent()
var assignedPill : wButton


func _ready():
	wSize = size
	pass


func _input(event):
	if event.is_action_pressed("l_click") and state == State.RESTING and canMove:
		state = State.HELD
		offset = whole_window.global_position - get_global_mouse_position()
		
	if event.is_action_released("l_click") and state == State.HELD:
		z_index = 1
		state = State.RESTING
		
	if event is InputEventMouseMotion and state == State.HELD:
		whole_window.position = event.position + offset


func _on_close_button_up() -> void:
	whole_window.queue_free()
	if assignedPill != null:
		assignedPill.queue_free()
	pass # Replace with function body.


func _on_minimize_button_up() -> void:
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	wm.minimize_window(whole_window)
	#whole_window.visible = false


func _on_mouse_entered() -> void:
	canMove = true

func _on_mouse_exited() -> void:
	canMove = false
	
func set_titlebar_label(label_text = "none"):
	$Title.text = label_text


	
