extends Label


func _process(delta: float) -> void:	
	# Display in label
	text = "%s  %s" % [WeaveTime.date_str, WeaveTime.time_no_sec_str]
