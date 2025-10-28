class_name decoded_log extends Control

@onready var rtl = $ColorRect2/MarginContainer/RichTextLabel
var decoder_step = 0

@export_multiline var section0 = "CONTEXT: Signal recording from a mold colony from the genus Stachybotrys, species S. chartarum, inhabiting the walls of Osmo/Za. Observations began on 02012010. Signals are provided SANS interpretation.

LOCATION: Slovenska cesta 52, 1000 Ljubljana.

DATE: 23092024

>> Connect the log to an TRANSCOFER, version 0.32 or higher to move to next page.
"

@export_multiline var section1coded: Array[String] = [
	"[00:12:27]>> suppression-pulse detected. (self-quench loop γ) 
>> COLONY IDENTIFIED.
>> SIGNAL: coherence loss; self-suppression ∆ +0.9s.",
	"[00:13:57] >> SIGNAL: hesitant doublet; two hyphal regions conflict (phase offset). VOC: trace chloroanisole.",
	"[00:14:42] >> SIGNAL: swallow-like amplitude collapse (analogous to human stifle).",
	"[00:15:07] >> VOC: brief ethanol spike after human odor signature increase in vicinity.",
	"[00:16:42] >> SIGNAL: aborted exhalation-like burst; waveform clipped by suppression node.",
	"[00:17:59] >> SIGNAL: synchronous lull; slow-wave building. Coherence gradually improving. Correlates with humidity drop."
	]
	
@export_multiline var section1decoded: Array[String] = [
	"→ INTERPRETATION: “—away.” ALT: “known threat”",
	"→ INTERPRETATION: “caught?”",
	"→ INTERPRETATION: “—don’t emit.  ALT: “suppress.” “—don’t emit.”",
	"→ INTERPRETATION: *unwelcoming of odor change* (conf 0.44)",
	"→ INTERPRETATION: “away” (conf 0.20) NOTE: likely addressed to external",
	"→ INTERPRETATION: “…undisturbed…good.” (conf 0.37)"
	]
	
@export_multiline var section2coded: Array[String] = [
	"[00:48:10] >> STARTING HUMIDITY: 1.2
	[00:48:27] >> SIGNAL: microvolt ripple detected. Possibly self-generated. HUM. CHANGE: -0.4",
	"[00:49:49] >> VOC: trace methyl ketone—weak, hesitant emission. HUM. CHANGE: -0.1",
	"[00:50:36] >> BACKGROUND: operator movement detected; vibrations elevate suppression. HUM. CHANGE: 0.0",
	"[01:01:58] >> SIGNAL: small cluster (γ-1) appearing, then folding back into silence. HUM. CHANGE: +0.7",
	"[01:02:27] >> VOC: faint terpenoid signature — resembles “curiosity” archetype. HUM. CHANGE: -0.5",
	"[01:02:44] >> SIGNAL: repeat pulse on same axis, slower now. HUM. CHANGE: 0.0",
	"[01:03:02] >> SIGNAL: suppression loop initiated; active concealment detected. HUM. CHANGE: 0.0",
	"[01:03:18] >> BACKGROUND: humidity down 1.3%. Activity stabilizing in low-signal band. HUM. CHANGE: +0.2"
	]
@export_multiline var section2decoded: Array[String] = [
	"→ INTERPRETATION: “…hello?”",
	"→ INTERPRETATION: “is it safe?”",
	"→ INTERPRETATION: “too stable.”",
	"→ INTERPRETATION: “hide / wait.”",
	"→ INTERPRETATION: “who listens?”",
	"→ INTERPRETATION: “I’m small.”",
	"→ INTERPRETATION: “hide” (conf 0.39)",
	"→ INTERPRETATION: “quiet feels good.” (conf 0.52)"
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
	rtl.install_effect(effect)
	var combined_string = String("\n").join(section1coded)
	rtl.text = combined_string
	




func _process(delta: float) -> void:
	pass
	
func display_page(page, decoded := false):
	rtl.text=""
	if page == 0:
		rtl.text = section0
		error_output("USE PG TO CHANGE PAGE")
	else:
		var currentPageCoded = get("section"+str(page)+"coded")
		#print(currentPageCoded)
		var currentPageDecoded = get("section"+str(page)+"decoded")
		#print(currentPageDecoded)
		#var combined_string = String("\n").join(currentPageCoded)
		for l in currentPageCoded:
			rtl.text += l +"\n"
			await get_tree().create_timer(0.1).timeout
			pass
		#text = combined_string
		if(decoded):
			decode_whole_section(currentPageCoded, currentPageDecoded)
	pass
	
func decode_whole_section(section,decoded, wait=true):
	for i in range(section.size()):
		insert_decoded_msg(section[i], decoded[i])
		if(wait):
			await get_tree().create_timer(0.3).timeout
	pass


func insert_decoded_msg(target, insert_txt):
	var pos = rtl.text.find(target)
	insert_txt = "\n[b]\t" + insert_txt + "[/b]"
	if pos != -1:
		rtl.text = rtl.text.substr(0, pos + target.length()) + insert_txt + rtl.text.substr(pos + target.length())
	pass


func set_page(value, spinbox : SpinBox) -> void:
	print("setting page ", value)
	decoder_step = int(value)
	spinbox.editable = false
	rtl.text = "..."
	error_output("LOADING NEW PAGE.")
	await get_tree().create_timer(0.2).timeout
	rtl.text = ".."
	error_output("LOADING NEW PAGE..")
	await get_tree().create_timer(0.2).timeout
	rtl.text = "."
	error_output("LOADING NEW PAGE...")
	await get_tree().create_timer(0.2).timeout
	display_page(decoder_step)
	var s = "PAGE " + str(decoder_step) +" LOADED"
	error_output(s)

	spinbox.editable = true
	pass # Replace with function body.


func transcode(humidity: Variant) -> void:
	if not visible:
		error_output("Log is not open.")
		print("Log is not open")
		return

	var currentPageCoded = get("section"+str(decoder_step)+"coded")
	var currentPageDecoded = get("section"+str(decoder_step)+"decoded")
	match decoder_step:
		0:
			print("NO SIGNAL TO TRANSCODE")
			error_output("NO SIGNAL TO TRANSCODE")
		1:
			decode_whole_section(currentPageCoded, currentPageDecoded)
		2:
			if humidity == 1.1:
				decode_whole_section(currentPageCoded, currentPageDecoded)
			else: error_output("HUMIDITY VALUE NOT VALID")
		3:
			pass
		4:
			pass
	pass # Replace with function body.
	
#func error_output():
	#print("bad input!")
	#pass
	
func error_output(message):
	var transcoder : Transcoder = get_tree().get_first_node_in_group("transcoder")
	if(transcoder == null): 
		print("cant find transcoder!")
		return
	else:
		transcoder.display_error(message)


func _on_rich_text_label_visibility_changed() -> void:
	pass # Replace with function body.
