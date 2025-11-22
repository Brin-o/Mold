extends Control
@export var lock = "4725"
var slogans = [
	"Nature in Digital",
 	"Computing the future, today.", 
	"Skate your dreams.",
	"One click away.",
	"Click, connect, create.",
	"Inspire, create, be you.",
	"The future is digital.",
	"Compatible with all WVdevices.",
	"In memorium of Barandishan Bu.",
	"Plug into the WEAVE®",]
var prev_slogan = ""
func _ready():
	WeaveTime.set_start_time()
	WeaveTime.time_scale
	get_lock_values()
	set_random_slogan()
	await get_tree().process_frame
	$Lock.position.y -= 80
	pass



func set_random_slogan():
	var new_slogan = prev_slogan
	while new_slogan == prev_slogan:
		new_slogan = slogans.pick_random()
	$Slogan.text = new_slogan
	prev_slogan = new_slogan
	pass



func get_lock_values() -> String:
	var lock_code = ""
	for l in $Lock/Lock/Code.get_children():
		var code = int(l.value)
		lock_code += str(code)
	return lock_code

func try_to_login():
	var current_value = get_lock_values()
	if current_value == lock:
		print("login")
		WeaveTime.set_start_time()
		WeaveTime.time_scale = 6
		get_tree().change_scene_to_file("res://Game.tscn")
		pass
	else:
		print("failed")
	


func _on_button_button_down() -> void:
	try_to_login()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		set_random_slogan()
	pass
