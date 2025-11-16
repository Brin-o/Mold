extends Control


var display_page = 1
@onready var page_spinner = $"../SpinBox"

func _ready() -> void:
	page_spinner.max_value = $Pages.get_child_count() + $ScrollContainer.get_child_count()
	display_page = int(page_spinner.value)
	set_active_page()
	await get_tree().process_frame
	capture_scrollcontainer($ScrollContainer)
	pass

func _on_spin_box_value_changed(value: float) -> void:
	display_page = int(value)
	set_active_page()


func set_active_page():
	print("displaying page ", display_page)
	if $ScrollContainer.get_child_count() != 0:
		var page_to_hide = $ScrollContainer.get_child(0)
		page_to_hide.reparent($Pages)
		page_to_hide.visible = false
	var page = $Pages.get_node(str(display_page))
	page.reparent($ScrollContainer)
	page.visible = true
	$ScrollContainer.scroll_vertical = 0
	pass
	

func capture_scrollcontainer(scroll_container: ScrollContainer, output_path := "user://scroll_capture.png") -> void:
	var content := scroll_container.get_child(0) as Control
	if content == null:
		push_error("❌ ScrollContainer has no child Control.")
		return

	var full_size := content.get_combined_minimum_size()
	if full_size == Vector2.ZERO:
		full_size = content.size
	full_size = full_size.round()
	print("📏 Full content size:", full_size)

	if full_size.x <= 0 or full_size.y <= 0:
		push_error("❌ Invalid size.")
		return

	# --- SubViewport setup ---
	var sv := SubViewport.new()
	sv.disable_3d = true
	sv.transparent_bg = false
	sv.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
	sv.render_target_update_mode = SubViewport.UPDATE_ONCE
	sv.size = full_size
	add_child(sv)

	# --- Duplicate content ---
	content.reparent(sv)
	content.position = Vector2.ZERO

	# Wait for render
	await RenderingServer.frame_post_draw
	await get_tree().process_frame

	var tex := sv.get_texture()
	if tex == null:
		push_error("❌ No texture generated.")
		sv.queue_free()
		return

	var img := tex.get_image()
	if img == null:
		push_error("❌ No image from texture.")
		sv.queue_free()
		return

	print("🖼️ Image size:", img.get_size(), " Empty?:", img.is_empty())
	print("📂 Saving to:", ProjectSettings.globalize_path(output_path))

	var err := img.save_png(output_path)
	if err != OK:
		push_error("❌ save_png failed with code: %s" % err)
	else:
		print("✅ Saved ScrollContainer capture to:", ProjectSettings.globalize_path(output_path))
		
	content.reparent(scroll_container)
	sv.queue_free()
	
