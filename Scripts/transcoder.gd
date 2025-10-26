extends Control

signal transcode (humidity)
signal paging_changed (page)

var humidity

func _ready():
	pass

func _on_button_button_down() -> void:
	var log : decoded_log = get_tree().get_first_node_in_group("log")
	if(log == null): 
		print("cant find log!")
		return
	else:
		print("transcode now")
		log.transcode(humidity)
	#transcode.emit(humidity)


func _humidity_changed(value: float) -> void:
	humidity = value


func _humidity_toggled(toggled_on: bool) -> void:
	humidity = false

# I put this in the parent
#func _on_spin_box_value_changed(value: float) -> void:
	#var log : decoded_log = get_tree().get_first_node_in_group("log")
	#if(log == null): 
		#print("cant find log!")
		#return
	#log.set_page(value, $Paging/SpinBox)
