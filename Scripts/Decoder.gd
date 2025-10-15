extends RichTextLabel


@export_multiline var section1coded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing.",
	"AGAIN persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
	
@export_multiline var section1decoded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]


#en array "pagov" se potem rabim
func _ready():
	var effect = BgColorEffect.new()
	install_effect(effect)
	var combined_string = String("\n").join(section1coded)
	text = combined_string
	


func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		decode_whole_section()
	pass
	
func decode_whole_section():
	for i in range(section1coded.size()):
		insert_decoded_msg(section1coded[i], section1decoded[i])
		await get_tree().create_timer(0.3).timeout
	pass


func insert_decoded_msg(target, insert_txt):
	var pos = text.find(target)
	insert_txt = "\n[b]" + insert_txt + "[/b]"
	if pos != -1:
		text = text.substr(0, pos + target.length()) + insert_txt + text.substr(pos + target.length())
	pass
