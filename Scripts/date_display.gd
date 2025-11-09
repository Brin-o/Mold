extends Label

var dt : DateTime

func _ready() -> void:
	dt = get_tree().get_first_node_in_group("date_time")

func _process(delta: float) -> void:
	text = dt.date_str
