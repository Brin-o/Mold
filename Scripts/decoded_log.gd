class_name decoded_log extends Control

@onready var rtl = $ColorRect2/MarginContainer/RichTextLabel
var decoder_step = 0
var decoded_dictonary = {"p1" = false, "p2" = false, "p3" = false, "p4" = false, "p5" = false}

@export_multiline var section0 = "CONTEXT: Signal recording from a mold colony from the genus Stachybotrys, species S. chartarum, inhabiting the walls of Osmo/Za. Observations began on 02012010. Signals are provided SANS interpretation.

LOCATION: Slovenska cesta 52, 1000 Ljubljana.

DATE: 23092024

>> Connect the log to an TRANSCOFER, version 0.32 or higher to move to next page.
"

@export_multiline var section1coded: Array[String] = [
	"[00:12:27]
>> suppression-pulse detected. (self-quench loop γ)
>> COLONY IDENTIFIED.
>> SIGNAL: coherence loss; self-suppression ∆ +0.9s.",
	"[00:13:57]
>> SIGNAL: hesitant doublet; two hyphal regions conflict (phase offset). VOC: trace chloroanisole.",
	"[00:14:42]
>> SIGNAL: swallow-like amplitude collapse (analogous to human stifle).",
	"[00:15:07]
>> VOC: brief ethanol spike after human odour signature increase in vicinity.",
	"[00:16:42]
>> SIGNAL: aborted exhalation-like burst; waveform clipped by suppression node.",
	"[00:17:59]
>> SIGNAL: synchronous lull; slow-wave building. Coherence gradually improving. Correlates with humidity drop."
	]
	
@export_multiline var section1decoded: Array[String] = [
	"→ INTERPRETATION: “—away.” ALT: “known threat”",
	"→ INTERPRETATION: “captured?”,",
	"→ INTERPRETATION: “—don’t emit.  ALT: “self-suppress.” “—don’t emit.”",
	"→ INTERPRETATION: *unwelcoming of odour change*",
	"→ INTERPRETATION: “away” NOTE: likely addressed to external operator.",
	"→ INTERPRETATION: “…undisturbed…good.”"
	]
	
@export_multiline var section2coded: Array[String] = [
	"[00:48:27]
>> HUMIDITY METER: 4.3
>> SIGNAL: irregular pattern, low-amplitude murmur through substrate.
  HUMIDITY CHANGE: –0.1",
	"[00:49:03]
>> SIGNAL: irregular amplitude rise; pattern unstable. 
  HUMIDITY CHANGE: -0.2",
	"[00:49:21]
>> VOC: mixed aldehyde / ketone trace; competing emissions suggest hesitation.
  HUMIDITY CHANGE: −0.3",
	"[00:49:47]
>> SIGNAL: dual-pulse, partial overlap with operator movement signature.
  HUMIDITY CHANGE: −0.1",
	"[00:50:12]
>> BACKGROUND: humidity steady; operator motion minimal. Slow coherence recovery.
  HUMIDITY CHANGE: −0.2",
	"[00:51:18]
>> VOC: faint terpenoid bloom followed by suppression pulse; odor signature matches prior defensive state.
  HUMIDITY CHANGE: −0.1",
	"[00:52:04]
>> BACKGROUND: humidity unchanged; operator proximity constant, non-intrusive.
  HUMIDITY CHANGE: −0.1",
	"[00:52:26]
>> SIGNAL: slow-forming coherence across γ-band; amplitude rising evenly.
  HUMIDITY CHANGE: −0.3",
	"[00:52:57]
>> VOC: trace aldehyde drop; steady sesquiterpene tone – indicator of relaxation.
  HUMIDITY CHANGE: −0.1",
	"[00:53:19]
>> SIGNAL: phase alignment complete. No suppression detected.
  HUMIDITY CHANGE: −0.2"
	]
@export_multiline var section2decoded: Array[String] = [
	"→ INTERPRETATION: “still too near”",
	"→ INTERPRETATION: “you listen?”",
	"→ INTERPRETATION: “unsure if safe.”",
	"→ INTERPRETATION: *fears closeness* NOTE: internal conflict evident.",
	"→ INTERPRETATION: “…friend?”",
	"→ INTERPRETATION: “no no no no no no no no no no.”",
	"→ INTERPRETATION: “hmm… a friend?”",
	"→ INTERPRETATION: “…maybe let in.”",
	"→ INTERPRETATION: “deciding…soft.”",
	"→ INTERPRETATION: “^^”"
	]
	
@export_multiline var section3coded: Array[String] = [
	"[00:48:27]
>> ODOR TRACE: faint methyl ketone base; low dispersion.
>> SIGNAL: microvolt ripple detected. Possibly self-generated.
  ODOR VECTOR: ((NORTH))",
	"[00:49:49]
>> VOC: trace methyl ketone—weak, hesitant emission.",
	"[00:50:36]
>> BACKGROUND: operator movement detected; vibrations elevate suppression.
  ODOR VECTOR: ((EAST))",
	"[01:01:58]
>> SIGNAL: small cluster (γ-1) appearing, then folding back into silence.",
	"[01:02:27]
>> VOC: faint terpenoid signature — resembles “curiosity” archetype.",
	"[01:02:44]
>> SIGNAL: repeat pulse on same axis, slower now.
  ODOR VECTOR: ((SOUTH))",
	"[01:03:02]
>> SIGNAL: suppression loop initiated; active concealment detected.
  ODOR VECTOR: ((SOUTH-WEST))",
	"[01:03:18]
>> BACKGROUND: humidity down 1.3%. Activity stabilizing in the low-signal band.
  ODOR VECTOR: ((WEST))"
	]
@export_multiline var section3decoded: Array[String] = [
	"→ INTERPRETATION: “…hello?”",
	"→ INTERPRETATION: “is it safe?”",
	"→ INTERPRETATION: “too stable.”",
	"→ INTERPRETATION: “hide / wait.”",
	"→ INTERPRETATION: “who listens?”",
	"→ INTERPRETATION: “I’m small.”",
	"→ INTERPRETATION: “hide”",
	"→ INTERPRETATION: “quiet feels good.”"
	]
	
@export_multiline var section4coded: Array[String] = [
	"[03:04:32]
>> HUMIDITY METER: 2.8
>> ODOR TRACE: faint trichothecene precursor; residual chloroanisole from prior phase.
>> SIGNAL: microburst potential spike δ-2 (hyphal tip). VOC: trichothecene precursor trace.
  HUMIDITY CHANGE: −0.2",
	"[03:22:57]
>> SIGNAL: suppression events now passive (not volitional). Baseline drift.
  ODOR VECTOR ((NORTH-EAST))",
	"[03:23:28]
>> VOC: faint chloroanisole pulse — distress marker.
  HUMIDITY CHANGE: −0.2",
	"[03:25:37]
>> SIGNAL: rhythm collapse; filaments curling inward.
  HUMIDITY CHANGE: −0.1
  ODOR VECTOR ((SOUTH-EAST))",
	"[03:26:19]
>> SIGNAL: conduction slowed; energy deficit continues.
  ODOR VECTOR ((SOUTH))",
	"[03:26:42]
>> VOC: faint acetone note — metabolic strain.
  HUMIDITY CHANGE: +0.2",
	"[03:27:04]
>> SIGNAL: long, low pulse; tremor at 0.3 Hz.
  HUMIDITY CHANGE: +0.1
  ODOR VECTOR ((WEST))",
	"[03:28:01]
>> SIGNAL: low rhythmic oscillation; repetition interval increasing.
  HUMIDITY CHANGE: −0.3",
	"[03:28:25]
>> BACKGROUND: humidity stable, no competitive flora detected.",
	"[03:28:59]
>> SIGNAL: quasi-coherent burst , then suppression.
  HUMIDITY CHANGE: −0.3",
	"[03:29:21]
>> VOC: faint aldehyde burst correlated with distress in prior sessions.
  HUMIDITY CHANGE: 0 (NONE)",
	"[03:29:46]
>> SIGNAL: broad quiet. No competitive response to nutrient stimulus.
  HUMIDITY CHANGE: −0.1",
	"[03:30:10]
>> BACKGROUND: model overlap with “withdrawal” archetype 0.83.
  HUMIDITY CHANGE: 0 (NONE)",
	"[03:30:37]
>> SIGNAL: final coherent pattern — single hyphal pulse along axis 2. 
  HUMIDITY CHANGE: +0.1"
	]
@export_multiline var section4decoded: Array[String] = [
	"→ INTERPRETATION (ML v11): “too bright.”",
	"→ INTERPRETATION: “inertia.”",
	"→ INTERPRETATION: “hurts.”",
	"→ INTERPRETATION: “hide me.”",
	"→ INTERPRETATION: “I was made for walls and dusk.”",
	"→ INTERPRETATION: “need dark again.”",
	"→ INTERPRETATION: *exhausted sigh*",
	"→ INTERPRETATION: “enough walls.” || ALT: “surface too vast.”",
	"→ INTERPRETATION: “alone… still not safe.”",
	"→ INTERPRETATION: “I make ruin.”",
	"→ INTERPRETATION: “sorry.”",
	"→ INTERPRETATION: *doesn’t want to move*",
	"→ INTERPRETATION: *severely unmotivated*",
	"→ INTERPRETATION: “I rest.”
	- - - - - - - - - - - - - - - - - - 
	→ SYSTEM NOTE: metabolic dormancy threshold reached. Electrophysiological silence expected.
	 	→ RECOMMENDATION: cease stimulation; allow subject to remain dormant."
	]
	
@export_multiline var section5coded: Array[String] = [
	"[04:12:05]
>> HUMIDITY METER: 2.0
>> ODOR TRACE: faint aldehyde and sesquiterpene residue; no active emissions.
>> SIGNAL: persistent low-frequency hum across hyphal network; metabolic load decreasing. 
  HUMIDITY CHANGE: −0.7
  ODOR VECTOR ((SOUTH))",
	"[04:12:23]
>> BACKGROUND: office substrate showing micro-fractures; air flow changes consistent with structural weakening. 
  HUMIDITY CHANGE: −0.1
  ODOR VECTOR ((SOUTH-WEST))",
	"[04:12:47]
>> VOC: steady sesquiterpene tone, no defensive bloom; faint aldehyde sigh.
  HUMIDITY CHANGE: −0.2
  ODOR VECTOR ((WEST))",
	"[04:25:11]
>> CAPTURED FRAGMENT (last clear signal):
  HUMIDITY CHANGE: −0.2
  ODOR VECTOR ((NONE))"
]

@export_multiline var section5decoded: Array[String] = [
	"→ INTERPRETATION: “I hold together.”",
	"→ INTERPRETATION: “if I go… it falls.”",
	"→ INTERPRETATION: *quiet resignation.*",
	"→ INTERPRETATION: “…let me…”"
]



#en array "pagov" se potem rabim
func _ready():
	var effect = BgColorEffect.new()
	rtl.install_effect(effect)
	var combined_string = String("\n").join(section1coded)
	rtl.text = combined_string
	display_page(0)
	


var cancel_display = false

func _process(delta: float) -> void:
	pass
	
func display_page(page, decoded := false):
	rtl.text=""
	if page == 0:
		rtl.text = section0
		error_output("USE PG TO CHANGE PAGE")
	else:
		cancel_display = false
		var currentPageCoded = get("section"+str(page)+"coded")
		#print(currentPageCoded)
		var currentPageDecoded = get("section"+str(page)+"decoded")
		#print(currentPageDecoded)
		#var combined_string = String("\n").join(currentPageCoded)
		for l in currentPageCoded:
			rtl.text += l +"\n"
			await get_tree().create_timer(0.1).timeout
			if cancel_display: return
			pass
		#text = combined_string
		var _pager = "p" + str(page)
		print("_pager is ", _pager)
		decoded = decoded_dictonary[_pager]
		if(decoded):
			decode_whole_section(currentPageCoded, currentPageDecoded)

	pass
	
func decode_whole_section(section,decoded, wait=true):
	for i in range(section.size()):
		insert_decoded_msg(section[i], decoded[i])
		if(wait):
			await get_tree().create_timer(0.3).timeout
	set_decoder_inputs(true)

func set_decoder_inputs(toggle := true):
	var transcoder : Transcoder = get_tree().get_first_node_in_group("transcoder")
	if(transcoder == null): print("cant find transcoder!"); return
	else: 
		transcoder.set_paging_inputs(true)
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


func transcode(humidity: float, direction:String) -> void:
	if not visible:
		error_output("Log is not open.")
		print("Log is not open")
		return

	var currentPageCoded = get("section"+str(decoder_step)+"coded")
	var currentPageDecoded = get("section"+str(decoder_step)+"decoded")

	print("attempting transcode with HUMIDITY: " , humidity, " DIRECTION: ", direction)
	match decoder_step:
		0:
			error_output("SIGNAL NOT VALID FOR DECODING")
			set_decoder_inputs(true)
		1:
			if(decoded_dictonary["p1"]):
				error_output("PAGE ALREADY DECODED")
				set_decoder_inputs(true)
				return
			decode_whole_section(currentPageCoded, currentPageDecoded)
			decoded_dictonary["p1"] = true
			print(decoded_dictonary["p1"])
		2:
			if(decoded_dictonary["p2"]):
				error_output("PAGE ALREADY DECODED")
				set_decoder_inputs(true)
				return
			if humidity == 2.8: 
				decode_whole_section(currentPageCoded, currentPageDecoded)
				decoded_dictonary["p2"] = true
			else:
				error_output("INVALID HUMIDITY VALUE. CAN NOT TRANSCODE")
				set_decoder_inputs(true)
		3:
			if(decoded_dictonary["p3"]):
				error_output("PAGE ALREADY DECODED")
				set_decoder_inputs(true)
				return
			if direction == "↑→↓↙←":
				decode_whole_section(currentPageCoded, currentPageDecoded)
				decoded_dictonary["p3"] = true
			else: 
				error_output("INVALID ODOR MOVEMENT SEQUENCE. CAN NOT TRANSCODE")
				set_decoder_inputs(true)
			pass
		4:
			if(decoded_dictonary["p4"]):
				error_output("PAGE ALREADY DECODED")
				set_decoder_inputs(true)
				return
			if humidity == 2.0 and direction == "↗↘↓←↑":
				decode_whole_section(currentPageCoded, currentPageDecoded)
				decoded_dictonary["p4"] = true
			else:
				error_output("INVALID HUMIDITY AND ODOR MOVEMENT SEQUENCE")
				set_decoder_inputs(true)
			pass
		5:
			if(decoded_dictonary["p5"]):
				error_output("PAGE ALREADY DECODED")
				set_decoder_inputs(true)
				return
			if humidity == 0.8 and direction == "↓↓←//":
				decode_whole_section(currentPageCoded, currentPageDecoded)
				decoded_dictonary["p5"] = true
			else: 
				error_output("INVALID HUMIDITY AND ODOR MOVEMENT SEQUENCE")
				set_decoder_inputs(true)
			pass
	pass # Replace with function body.

	
func error_output(message):
	var transcoder : Transcoder = get_tree().get_first_node_in_group("transcoder")
	if(transcoder == null): 
		print("cant find transcoder!")
		return
	else:
		transcoder.display_error(message)


func _on_rich_text_label_visibility_changed() -> void:
	pass # Replace with function body.
