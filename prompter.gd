extends RichTextLabel

var loading = false

var test_value : String = "lalalalal test"
#
#func _init() -> void:
	#text_display("this is a test by brin")

func text_display(t):
	clear()
	loading = true
	for i in 10:
		text = "..."
		await get_tree().create_timer(0.2).timeout
		text = ".."
		await get_tree().create_timer(0.2).timeout	
	text = t
	pass
