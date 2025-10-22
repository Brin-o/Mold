extends RichTextLabel


var decoder_step = 0

@export_multiline var section0 = "CONTEXT: Signal recording from a mold colony from the genus Stachybotrys, species S. chartarum, inhabiting the walls of Osmo/Za. Observations began on 02012010. Signals are provided SANS interpretation.
Recent: Connect the log to an interpreter, version 0.32 or higher.
LOCATION: Slovenska cesta 52, 1000 Ljubljana.
DATE: 23092024 "

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
	
@export_multiline var section5coded: Array[String] = [
	"bla bla",
	]
@export_multiline var section5decoded: Array[String] = [
	">>ble ble",
	]
	
	


#en array "pagov" se potem rabim
func _ready():
	var effect = BgColorEffect.new()
	install_effect(effect)
	var combined_string = String("\n").join(section1coded)
	text = combined_string
	




func _process(delta: float) -> void:
	decoder_step = int(%SpinBox.value)
	if Input.is_action_just_released("ui_accept") and decoder_step >= 0:
		var currentPageCoded = get("section"+str(decoder_step)+"coded")
		var currentPageDecoded = get("section"+str(decoder_step)+"decoded")
		decode_whole_section(currentPageCoded, currentPageDecoded)
	pass
	
func display_page(page, decoded := false):
	if page == 0:
		text = section0
	else:
		var currentPageCoded = get("section"+str(page)+"coded")
		#print(currentPageCoded)
		var currentPageDecoded = get("section"+str(page)+"decoded")
		#print(currentPageDecoded)
		var combined_string = String("\n").join(currentPageCoded)
		text = combined_string
		if(decoded):
			print("decoding!")
			decode_whole_section(currentPageCoded, currentPageDecoded)
	pass
	
func decode_whole_section(section,decoded, wait=true):
	for i in range(section.size()):
		insert_decoded_msg(section[i], decoded[i])
		if(wait): 
			await get_tree().create_timer(0.3).timeout
	pass


func insert_decoded_msg(target, insert_txt):
	var pos = text.find(target)
	insert_txt = "\n[b]\t" + insert_txt + "[/b]"
	if pos != -1:
		text = text.substr(0, pos + target.length()) + insert_txt + text.substr(pos + target.length())
	pass


func _on_spin_box_value_changed(value: float) -> void:
	var page = int(value)
	%SpinBox.editable = false
	text = "..."
	await get_tree().create_timer(0.2).timeout
	text = ".."
	await get_tree().create_timer(0.2).timeout
	text = "."
	await get_tree().create_timer(0.2).timeout
	display_page(page)
	%SpinBox.editable = true
	pass # Replace with function body.
