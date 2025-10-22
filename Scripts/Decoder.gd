extends RichTextLabel


var decoder_step = 0


@export_multiline var section1coded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing.",
	"AGAIN persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
	
@export_multiline var section1decoded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
	
@export_multiline var section2coded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing.",
	"AGAIN persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
@export_multiline var section2decoded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
	
@export_multiline var section3coded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing.",
	"AGAIN persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
@export_multiline var section3decoded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
	
@export_multiline var section4coded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing.",
	"AGAIN persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]
@export_multiline var section4decoded: Array[String] = [
	"persistent low-frequency hum across hyphal network; metabolic load decreasing."
	]


#en array "pagov" se potem rabim
func _ready():
	var effect = BgColorEffect.new()
	install_effect(effect)
	var combined_string = String("\n").join(section1coded)
	text = combined_string
	

func display_page(page, decoded := false):
	var currentPage = get("section"+str(page)+"coded")
	var combined_string = String("\n").join(currentPage)
	if(decoded):
		decode_whole_section(currentPage)
	text = combined_string
	pass


func _process(delta: float) -> void:
	decoder_step = int(%SpinBox.value)
	if Input.is_action_just_released("ui_accept"):
		display_page(decoder_step)
	pass
	
func decode_whole_section(section, wait=false):
	
	for i in range(section.size()):
		insert_decoded_msg(section[i], section[i])
		if(wait): 
			await get_tree().create_timer(0.3).timeout
	pass


func insert_decoded_msg(target, insert_txt):
	var pos = text.find(target)
	insert_txt = "\n[b]" + insert_txt + "[/b]"
	if pos != -1:
		text = text.substr(0, pos + target.length()) + insert_txt + text.substr(pos + target.length())
	pass
