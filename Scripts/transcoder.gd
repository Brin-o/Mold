class_name Transcoder extends Control


var humidity = false
var humidity_value = 4.8
var movement = false
var movement_set = ""
@onready var error_label = $ErrorOutput/Margin/RichTextLabel
var log : decoded_log
var log_connected = true
var _current_error_anim_id : int = 0

var _error_current_message: String = ""
var _error_interrupt: bool = false
var _error_task_running: bool = false
var _error_blink_only: bool = false



func _ready():
	check_for_active_log(true)
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
	log  = get_tree().get_first_node_in_group("log")
	if(log == null):
		display_blinking_error("No LOG to decode!")
		return
	else: 
		set_paging_inputs(false)
		display_blinking_error("DECODING")
		log.transcode(humidity_output, movement_output)



func _humidity_changed(value: float) -> void:
	humidity_value = value


func _humidity_toggled(toggled_on: bool) -> void:
	humidity = false
	$Humidity/SpinBox.editable = toggled_on

func _safe_wait(time: float, id: int) -> void:
	var timer := get_tree().create_timer(time)
	await timer.timeout
	if id != _current_error_anim_id:
		# Animation was cancelled; stop coroutine here
		return

func display_error(message: String) -> void:
	_error_current_message = message
	_error_interrupt = true

	# If the task loop is not running, start it
	if not _error_task_running:
		_error_handler()

func display_blinking_error(message: String) -> void:
	_error_current_message = message
	_error_interrupt = true
	_error_blink_only = true   # tell the engine to use the blink animation

	if not _error_task_running:
		_error_handler()


func _error_handler() -> void:
	_error_task_running = true

	while true:
		_error_interrupt = false
		var msg = _error_current_message
		var blink_only = _error_blink_only

		# Run animation depending on mode
		if blink_only:
			await _error_anim_blink_only(msg)
		else:
			await _error_anim_full(msg)

		# If not interrupted, animation ends
		if not _error_interrupt:
			break
		# Otherwise loop and restart with updated message
		continue
	_error_task_running = false

	
	
func _error_anim_full(message: String) -> void:
	var label = error_label

	label.text = "..."
	if await _wait_interruptible(0.1): return
	label.text = ".."
	if await _wait_interruptible(0.1): return
	label.text = "."
	if await _wait_interruptible(0.1): return
	label.text = message
	if await _wait_interruptible(0.5): return
	label.text = ""
	if await _wait_interruptible(0.5): return
	label.text = message
	if await _wait_interruptible(0.5): return
	label.text = ""
	if await _wait_interruptible(0.5): return
	label.text = message
	
func _error_anim_blink_only(message: String) -> void:
	var label = error_label

	label.text = message
	if await _wait_interruptible(0.5): return
	label.text = ""
	if await _wait_interruptible(0.5): return
	label.text = message
	if await _wait_interruptible(0.5): return
	label.text = ""
	if await _wait_interruptible(0.5): return
	label.text = message



func _wait_interruptible(t: float) -> bool:
	var timer = get_tree().create_timer(t)
	await timer.timeout
	return _error_interrupt    # true = interruption happened


func blinking_colored_error(message, color):
	
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

func _process(delta: float) -> void:
	check_for_active_log()
	pass
	
func check_for_active_log(instant = false):
	log = get_tree().get_first_node_in_group("log")
	if log != null and !log_connected: 
		log_connected = true
		log_connection_sequence(instant)
	if log == null and log_connected:
		log_connected = false
		log_disconnect_sequence(instant)
	pass
	
func log_connection_sequence(instant = false):
	var wait_time = 0.4
	enable_element($Paging)
	$Paging/SpinBox.editable = true
	if(!instant): await get_tree().create_timer(wait_time).timeout
	enable_element($Humidity)
	$Humidity/CheckBox.disabled = false
	if(!instant): await get_tree().create_timer(wait_time).timeout
	enable_element($Movement)
	$Movement/CheckBox.disabled = false
	if(!instant): await get_tree().create_timer(wait_time).timeout
	display_error("LOG CONNECTED
	FUNCTIONS ONLINE")
	pass

func log_disconnect_sequence(instant = false):
	var wait_time = 0.4
	disable_element($Paging)
	$Paging/SpinBox.editable = false
	if(!instant): await get_tree().create_timer(wait_time).timeout
	disable_element($Humidity)
	$Humidity/CheckBox.disabled = true
	if(!instant): await get_tree().create_timer(wait_time).timeout
	disable_element($Movement)
	$Movement/CheckBox.disabled = true
	if(!instant): await get_tree().create_timer(wait_time).timeout
	display_error("NO LOG TO DECODE, OPEN A LOG")
	pass


func disable_element(element : Control):
	element.modulate = Color(1,1,1,0.2)
	recursive_mouse_filter_set(element, Control.MOUSE_FILTER_IGNORE)
	pass
	
func recursive_mouse_filter_set(element:Control, mouse_filter):
	mouse_filter = mouse_filter
	for c in element.get_children():
		recursive_mouse_filter_set(c, mouse_filter)



func enable_element(element : Control):
	element.modulate = Color(1,1,1)
	recursive_mouse_filter_set(element, Control.MOUSE_FILTER_STOP)
	pass
