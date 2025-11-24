extends Button


func _on_button_down() -> void:
	var wm : ManagerWindows = get_tree().get_first_node_in_group("window_manager")
	if (wm != null): wm.open_or_focus_msn()
