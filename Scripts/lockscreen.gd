extends Control
@export var lock = "4725"
var slogans = ["Nature in Digital", "Computing the future, today.", "Skate your dreams.", "One click away.", "Click, connect, create.", "Inspire, create, be you.", "The future is digital.", "Compatible with all WVdevices.", "In memorium of Barandishan Bu.", "Plug into the WEAVE®", ""]

func _ready():
	get_lock_values()
	set_random_slogan()
	pass



func set_random_slogan():
	$Slogan.text = slogans.pick_random()
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
		get_tree().change_scene_to_file("res://Game.tscn")
		pass
	else:
		print("failed")
	


func _on_button_button_down() -> void:
	try_to_login()
