class_name window_parent extends Control

signal click (sending_window)
var canMove : bool
#var window_name = "GenericWindow"


func _ready():
	fit_to_children()
	mouse_filter = Control.MOUSE_FILTER_STOP  # Don’t block children


func center_to_screen():
	var vSize = get_viewport_rect().size
	print(size)
	var rr = 100
	var randomisation = Vector2(randi_range(-rr,rr),randi_range(0,rr))
	position = vSize/2 - size/2 + randomisation
	pass

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
			click.emit(self)
			#emit_signal("click")


func set_titlebar_label(label_text):
	#window_name = label_text
	$Titlebar.set_titlebar_label(label_text)


func load_content(content_path):
	$Contents.load_contents(content_path)
	pass
	
func fit_height():
	print($Contents.get_minimum_size())
	var ySize = $Contents.get_minimum_size().y
	$Contents.size.y = $Contents.get_minimum_size().y
	$Shadow/Base.size.y = ySize + 10
	fit_to_children()
	pass
