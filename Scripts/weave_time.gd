extends Node
# How many in-game seconds pass per real second.
# Example: 60 = 1 real second = 1 in-game minute (1 real minute = 1 in-game hour)
var time_scale: float = 2

# Internal variables
var game_time: Dictionary
var base_unix_time: float
var time_str := ""
var time_no_sec_str := ""

var date_str := ""

var current_hour: float = 0.0
var current_minute: float = 0.0
var current_seconds: float = 0.0


func _ready() -> void:
	set_start_time()
	
func set_start_time():
	game_time = Time.get_datetime_dict_from_system()
	# Convert to Unix timestamp (seconds since 1970)
	base_unix_time = Time.get_unix_time_from_datetime_dict(game_time)
	set_process(true)

func _process(delta: float) -> void:
	var elapsed_real = delta
	var elapsed_game = elapsed_real * time_scale

	base_unix_time += elapsed_game
	
	var new_time = Time.get_datetime_dict_from_unix_time(base_unix_time)

	current_hour = float(new_time.hour)
	current_minute = float(new_time.minute)
	current_seconds = float(new_time.second)

	date_str = "%04d-%02d-%02d" % [new_time.year, new_time.month, new_time.day]
	time_str = "%02d:%02d:%02d" % [new_time.hour, new_time.minute, new_time.second]
	time_no_sec_str = "%02d:%02d" % [new_time.hour, new_time.minute]
