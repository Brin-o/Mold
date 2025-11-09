extends Control


var display_page = 1
@onready var page_spinner = $"../SpinBox"

func _ready() -> void:
	page_spinner.max_value = $Pages.get_child_count() + $ScrollContainer.get_child_count()
	display_page = int(page_spinner.value)
	set_active_page()
	pass

func _on_spin_box_value_changed(value: float) -> void:
	display_page = int(value)
	set_active_page()


func set_active_page():
	print("displaying page ", display_page)
	if $ScrollContainer.get_child_count() != 0:
		var page_to_hide = $ScrollContainer.get_child(0)
		page_to_hide.reparent($Pages)
		page_to_hide.visible = false
	var page = $Pages.get_node(str(display_page))
	page.reparent($ScrollContainer)
	page.visible = true
	pass
