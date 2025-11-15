class_name Transcoder extends Control


var humidity = false
var humidity_value = 4.8
var movement = false
var movement_set = ""
@onready var error_label = $ErrorOutput/Margin/RichTextLabel


func _ready():
	pass

func _on_button_button_down() -> void:
	var humidity_output = -99
	if $Humidity/CheckBox.button_pressed:
		humidity_output = humidity_value
	var movement_output = "DISABLED"
	movement_set = ""
	if $Movement/CheckBox.button_pressed:
		var options := $Movement/Options
		for opt in options.get_children():
			movement_set += opt.text
		movement_output = movement_set
		#print(movement_set)
	var log : decoded_log = get_tree().get_first_node_in_group("log")
	if(log == null):
		display_error("No LOG to decode!") #why does this not work :(
		print("cant find log!")
		return
	else: 
		set_paging_inputs(false)
		log.transcode(humidity_output, movement_output)



func _humidity_changed(value: float) -> void:
	humidity_value = value


func _humidity_toggled(toggled_on: bool) -> void:
	humidity = false
	$Humidity/SpinBox.editable = toggled_on

func display_error(message):
	error_label.text = message
	pass




func set_paging_inputs(toggle := true):
	print("Setting transcoder input to ", toggle)
	$Paging/SpinBox.editable = toggle
	$Button.disabled = !toggle


func _on_movement_toggled(toggled_on: bool) -> void:
	movement = toggled_on
	var options := $Movement/Options
	for opt in options.get_children():
		opt.disabled = !toggled_on
	pass # Replace with function body.
