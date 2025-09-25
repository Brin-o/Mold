class_name window_parent extends Control

signal click (sending_window)
var canMove : bool


func _ready():
	fit_to_children()
	mouse_filter = Control.MOUSE_FILTER_STOP  # Don’t block children

func fit_to_children():
	var rect := Rect2()
	var first := true

	for child in get_children():
		if child is Control:
			var child_rect := Rect2(child.position, child.size)
			if first:
				rect = child_rect
				first = false
			else:
				rect = rect.merge(child_rect)

	size = rect.size
	position = rect.position

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var top :Control= get_viewport().gui_get_hovered_control()
		#print(top.get_parent_control())
		if top == self or top.is_ancestor_of(self) or self.is_ancestor_of(top):
			print("click from " + name)
			click.emit(self)
			#emit_signal("click")
