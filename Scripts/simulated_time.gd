extends Label

# How many in-game seconds pass per real second.
# Example: 60 = 1 real second = 1 in-game minute (1 real minute = 1 in-game hour)
@export var time_scale: float = 60.0

# Internal variables
var game_time: Dictionary
var base_unix_time: float

func _ready() -> void:
	# Get current real-world date & time
	game_time = Time.get_datetime_dict_from_system()
	# Convert to Unix timestamp (seconds since 1970)
	base_unix_time = Time.get_unix_time_from_datetime_dict(game_time)
	set_process(true)

func _process(delta: float) -> void:
	# Advance simulated in-game time
	var elapsed_real = Engine.get_physics_frames() * delta
	var elapsed_game = elapsed_real * time_scale
	
	# Compute new in-game Unix timestamp
	var simulated_unix_time = base_unix_time + elapsed_game
	var new_time = Time.get_datetime_dict_from_unix_time(simulated_unix_time)
	
	# Format date & time
	var date_str = "%04d-%02d-%02d" % [new_time.year, new_time.month, new_time.day]
	var time_str = "%02d:%02d" % [new_time.hour, new_time.minute]
	
	# Display in label
	text = "%s  %s" % [date_str, time_str]
