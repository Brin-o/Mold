class_name window_parent extends Control

@export var auto_fit_height: bool = false
@export var auto_fit_on_ready: bool = false

signal click (sending_window)
var canMove : bool
#var window_name = "GenericWindow"


func _ready():
	if auto_fit_on_ready:
		fit_to_children()
	mouse_filter = Control.MOUSE_FILTER_STOP  # Don’t block children
	# Keep Shadow/Base in sync with Contents when not auto-fitting height
	if has_node("Contents"):
		var contents: Control = $Contents
		if contents:
			contents.resized.connect(_on_contents_resized)
			contents.minimum_size_changed.connect(_on_contents_minimum_size_changed)
			call_deferred("_update_shadow_base_size")


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

	var new_size := size
	var new_pos := position
	new_size.x = rect.size.x
	new_pos.x = rect.position.x
	if auto_fit_height:
		new_size.y = rect.size.y
		new_pos.y = rect.position.y
	size = new_size
	position = new_pos
	if not auto_fit_height:
		_update_shadow_base_size()

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
	if not auto_fit_height:
		_update_shadow_base_size()
		return
	print($Contents.get_minimum_size())
	var ySize = $Contents.get_minimum_size().y
	$Contents.size.y = $Contents.get_minimum_size().y
	$Shadow/Base.size.y = ySize + 10
	fit_to_children()
	pass

func set_auto_fit_height(enabled: bool) -> void:
	auto_fit_height = enabled
	_update_shadow_base_size()

func _on_contents_resized() -> void:
	_update_shadow_base_size()

func _on_contents_minimum_size_changed() -> void:
	_update_shadow_base_size()

func _update_shadow_base_size() -> void:
	if auto_fit_height:
		return
	if not has_node("Shadow/Base") or not has_node("Contents"):
		return
	var base: Control = $Shadow/Base
	var contents: Control = $Contents
	# Match Base to current Contents size when auto-fit is disabled
	var new_size = contents.size
	new_size.x += 10
	new_size.y += 10
	base.size = new_size


func _paging_value_changed(value: float) -> void:
	var log : decoded_log = get_tree().get_first_node_in_group("log")
	if(log == null): 
		print("cant find log!")
		return
	log.set_page(value, $Transcoder/Paging/SpinBox)
