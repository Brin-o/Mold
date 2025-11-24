extends Control

var t = 0
var max_time = 10

func _process(delta: float) -> void:
	t += delta
	if t>max_time:
		visible = true
		var t_left = 25 - t
		t_left = int(t_left)
		$Timer.text = "Logging off in " + str(t_left)
		if t_left < 0:
			t = 0
			get_tree().change_scene_to_file("res://Scenes/lockscreen.tscn")
	pass

func offer_reset():
	pass


func _input(event):
	if(event != null):
		t = 0
		visible = false
