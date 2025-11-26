extends Control


func _on_submit_button_up() -> void:
	$Label.visible = true
	#await get_tree().create_timer(0.4).timeout
	#$Print.visible = true
	


func _on_print_button_up() -> void:
	#$Label_Print.visible = true
	#$"../..".export_form()
	pass
