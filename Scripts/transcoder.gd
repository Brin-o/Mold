class_name Transcoder extends Control


var humidity = false
var movement = false
var movement_set = ""
@onready var error_label = $ErrorOutput/Margin/RichTextLabel

func _ready():
	pass

func _on_button_button_down() -> void:
	if movement != false:
		var options := $Movement/Options
		movement_set = ""
		for opt in options.get_children():
			movement_set += opt.text
		print(movement_set)
	#print($Movement/Options/OptionButton.text)
	
	var log : decoded_log = get_tree().get_first_node_in_group("log")
	if(log == null): print("cant find log!"); return
	else: 
		log.transcode(humidity)
	#transcode.emit(humidity)


func _humidity_changed(value: float) -> void:
	humidity = value


func _humidity_toggled(toggled_on: bool) -> void:
	humidity = false
	$Humidity/SpinBox.editable = toggled_on

# I put this in the parent
#func _on_spin_box_value_changed(value: float) -> void:
	#var log : decoded_log = get_tree().get_first_node_in_group("log")
	#if(log == null): 
		#print("cant find log!")
		#return
	#log.set_page(value, $Paging/SpinBox)
func display_error(message):
	error_label.text = message
	pass




func _on_check_box_toggled(toggled_on: bool) -> void:
	movement = toggled_on
	var options := $Movement/Options
	for opt in options.get_children():
		opt.disabled = !toggled_on
	pass # Replace with function body.
