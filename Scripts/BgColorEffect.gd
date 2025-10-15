extends RichTextEffect
class_name BgColorEffect

# BBCode tag: [bg=...]...[/bg]
var bbcode := "bg"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	# default bg
	var bg_color := Color(1, 1, 0, 0.4)

	# parse parameter if present
	if char_fx.env.has("bg"):
		var param := str(char_fx.env["bg"]).strip_edges()
		# try hex first
		if Color.html_is_valid(param):
			bg_color = Color.html(param)
		else:
			match param.to_lower():
				"red":    bg_color = Color(1, 0, 0, 0.4)
				"green":  bg_color = Color(0, 1, 0, 0.4)
				"blue":   bg_color = Color(0, 0, 1, 0.4)
				"yellow": bg_color = Color(1, 1, 0, 0.4)
				_:
					# fallback: warn once (useful for debugging)
					push_warning("BgColorEffect: invalid color param for [bg]: '%s'" % param)

	# draw pass: draw a rectangle behind each glyph
	if char_fx.drawing:
		# glyph_size is Vector2(width, height)
		var gs = char_fx.glyph_size
		# small padding so highlight isn't flush to glyph
		var pad := Vector2(6.0, 4.0)
		var rect := Rect2(char_fx.position - pad, gs + pad * 2.0)

		# Draw rounded rect. Last arg is radius for corners (Godot 4.x).
		# If your engine doesn't support radius arg, remove the last parameter.
		char_fx.canvas_item.draw_rect(rect, bg_color, true, 6.0)

	return true
