extends Node2D

enum {HOUR, MINUTE, SECONDS}
const HOUR_HAND_LENGHT = 30
const MINUTE_HAND_LENGHT = 50

func _process(delta)->void:
	$HH.points[1] = calculate_hand_tip_location(HOUR)
	$MM.points[1] = calculate_hand_tip_location(MINUTE)
	$SS.points[1] = lerp($SS.get_point_position(1), calculate_hand_tip_location(SECONDS), delta*10)
	pass

func calculate_hand_tip_location(hand)->Vector2:
	var lenght 
	var angle
	match hand:
		SECONDS:
			lenght = MINUTE_HAND_LENGHT
			angle = deg_to_rad(WeaveTime.current_seconds*6)
		MINUTE:
			lenght = MINUTE_HAND_LENGHT
			angle = deg_to_rad(WeaveTime.current_minute*6)#pass in min
		HOUR:
			lenght = HOUR_HAND_LENGHT
			angle = deg_to_rad(WeaveTime.current_hour * 30.0 + WeaveTime.current_minute*0.5) #hour * 30 * min
	var x = lenght * sin(angle)
	var y = -lenght*cos(angle)
	return Vector2(x,y)
