extends Button

var new_ttt = load("res://Scenes/tictactoe.tscn")



func _on_button_down() -> void:
	var current = $"../tictactoe"
	current.queue_free()
	await get_tree().process_frame
	var new = new_ttt.instantiate()
	new.position = Vector2(11, 11)
	new.size = Vector2(218,193)
	$"..".add_child(new)
	self.reparent($"..")
