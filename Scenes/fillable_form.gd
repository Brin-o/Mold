extends Control


var display_page = 1
@onready var page_spinner = $"../SpinBox"
var max_page

func _ready() -> void:
	max_page = $Pages.get_child_count()
	#export_form()
	#debug_print_tree()
	page_spinner.max_value = $Pages.get_child_count() + $ScrollContainer.get_child_count()
	display_page = int(page_spinner.value)
	set_active_page()
	await get_tree().process_frame
	#capture_scrollcontainer($ScrollContainer)
	
	pass

func _on_spin_box_value_changed(value: float) -> void:
	if(value > max_page): 
		value = max_page
	display_page = int(value)
	set_active_page()


func set_active_page():
	print("displaying page ", display_page)
	if $ScrollContainer.get_child_count() != 0:
		var page_to_hide = $ScrollContainer.get_child(0)
		page_to_hide.reparent($Pages)
		page_to_hide.visible = false
	var page = $Pages.get_node(str(display_page))
	if(page == null): return
	page.reparent($ScrollContainer)
	page.visible = true
	$ScrollContainer.scroll_vertical = 0
	pass




@export var pages_parent: Node
var output_lines: Array[String] = []

func print_file(file_path):
	var abs_path = ProjectSettings.globalize_path(file_path)
	print("Preparing to print file at" , file_path, " abs path: ", abs_path)
	var cmd = "cp"
	var args = [abs_path, "/dev/usb/lp0"]
	await get_tree().process_frame
	var output = []
	var result = OS.execute(cmd, args, output, true)
	print("Command result: ", result, " Output: ", output)


func export_form():
	output_lines.clear()

	var pages := pages_parent.get_children()

	for i in pages.size():
		_write_page_header(pages[i], i + 1)
		_process_page(pages[i])
		output_lines.append("")

	var p = _save_output_file()
	print_file(p)
	print("Form exported.")



# -------------------------------------------------------
# PAGE HEADER
# -------------------------------------------------------

func _write_page_header(page: Node, page_num: int):
	output_lines.append("===== Page %s =====" % page_num)

	# Try to find page header text (Label under a ColorRect usually)
	var header_text := _find_first_label_text(page, ["Header"])
	var subheader_text := _find_first_label_text(page, ["Header2", "Subheader"])

	if header_text != "":
		output_lines.append(header_text)
	if subheader_text != "":
		output_lines.append(subheader_text)

	output_lines.append("")


func _find_first_label_text(root: Node, keywords: Array[String]) -> String:
	for child in root.get_children():
		for keyword in keywords:
			if keyword.to_lower() in child.name.to_lower():
				var t := _find_label_text_anywhere(child)
				if t != "":
					return t
	return ""


func _find_label_text_anywhere(node: Node) -> String:
	if node is Label:
		return node.text.strip_edges()
	for child in node.get_children():
		var t := _find_label_text_anywhere(child)
		if t != "":
			return t
	return ""


# -------------------------------------------------------
# PROCESS PAGE CONTENT
# -------------------------------------------------------

func _process_page(page: Node):
	# We walk only the main VBoxContainer for user content.
	var vbox := _find_main_vbox(page)
	if vbox:
		for child in vbox.get_children():
			_process_question_block(child)


func _find_main_vbox(root: Node) -> VBoxContainer:
	for c in root.get_children():
		if c is VBoxContainer:
			return c
	return null   # fallback


# -------------------------------------------------------
# PROCESS QUESTION BLOCK
# -------------------------------------------------------

func _process_question_block(block: Node):
	var question := _find_label_text_anywhere(block)

	var line_edits := _find_all_line_edits(block)
	var text_edits := _find_all_text_edits(block)
	var checkboxes := _find_all_checkboxes(block)
	var spinboxes := _find_all_spinboxes(block)
	var richtexts := _find_all_richtext(block)

	# Skip blocks that really contain nothing
	if question == "" and \
		line_edits.is_empty() and \
		text_edits.is_empty() and \
		checkboxes.is_empty() and \
		spinboxes.is_empty() and \
		richtexts.is_empty():
		return

	# --- WRITE QUESTION ---
	if question != "":
		output_lines.append(question)

# --- DATE SPECIAL CASE (any 3 SpinBoxes) ---
	if spinboxes.size() == 3:
		#if question != "":
			#output_lines.append(question)  # write the question label
		var year := int(spinboxes[0].value)
		var month := int(spinboxes[1].value)
		var day := int(spinboxes[2].value)
		output_lines.append("%04d / %02d / %02d" % [year, month, day])
		output_lines.append("")
		return


	# --- WRITE RICHTEXT ANSWERS ---
	for rt in richtexts:
		var t := rt.text.strip_edges()
		if t != "":
			output_lines.append(t)

	# --- WRITE TEXT INPUT (LineEdit) ---
	for le in line_edits:
		var t := le.text.strip_edges()
		if t != "":
			output_lines.append(t)

	# --- WRITE MULTILINE TEXT INPUT ---
	for te in text_edits:
		var t := te.text.strip_edges()
		if t != "":
			output_lines.append(t)
			output_lines.append("")

	# --- WRITE CHECKBOXES ---
	if not checkboxes.is_empty():
		for cb in checkboxes:
			var mark := "(x)" if cb.button_pressed else "( )"
			var text := cb.text.strip_edges()
			var other := _find_lineedit_under_node(cb)

			if other != "":
				output_lines.append("%s %s %s" % [mark, text, other])
			else:
				output_lines.append("%s %s" % [mark, text])

		output_lines.append("")

# -------------------------------------------------------
# HELPERS FOR EXTRACTING INPUT NODES
# -------------------------------------------------------

func _find_all_line_edits(node: Node) -> Array[LineEdit]:
	var arr: Array[LineEdit] = []
	for c in node.get_children():
		if c is LineEdit:
			arr.append(c)
		else:
			arr += _find_all_line_edits(c)
	return arr


func _find_all_text_edits(node: Node) -> Array[TextEdit]:
	var arr: Array[TextEdit] = []
	for c in node.get_children():
		if c is TextEdit:
			arr.append(c)
		else:
			arr += _find_all_text_edits(c)
	return arr


func _find_all_checkboxes(node: Node) -> Array[CheckBox]:
	var arr: Array[CheckBox] = []
	for c in node.get_children():
		if c is CheckBox:
			arr.append(c)
		else:
			arr += _find_all_checkboxes(c)
	return arr


func _find_lineedit_under_node(node: Node) -> String:
	for c in node.get_children():
		if c is LineEdit:
			return c.text.strip_edges()
		var t := _find_lineedit_under_node(c)
		if t != "":
			return t
	return ""


# -------------------------------------------------------
# SAVE FILE
# -------------------------------------------------------

func _save_output_file():
	var index := 1
	while FileAccess.file_exists("user://form_export_%s.txt" % index):
		index += 1

	var path := "user://form_export_%s.txt" % index
	var file := FileAccess.open(path, FileAccess.WRITE)

	# Apply folding to your existing output_lines
	var folded_lines = fold_lines_soft(output_lines, 70)

	for line in folded_lines:
		file.store_line(line)

	file.close()
	print("Saved: ", path)
	return path
	
func debug_print_tree():
	print("\n===== DEBUG TREE START =====\n")

	var pages := pages_parent.get_children()
	for i in pages.size():
		print("PAGE %s: %s" % [i + 1, pages[i].name])
		_debug_print_node_recursive(pages[i], 1)

	print("\n===== DEBUG TREE END =====\n")

func _debug_print_node_recursive(node: Node, indent: int):
	var indent_str := "    ".repeat(indent)
	print("%s- %s (%s)" % [indent_str, node.name, node.get_class()])

	for child in node.get_children():
		_debug_print_node_recursive(child, indent + 1)


func _find_all_spinboxes(node: Node) -> Array[SpinBox]:
	var arr: Array[SpinBox] = []
	for c in node.get_children():
		if c is SpinBox:
			arr.append(c)
		else:
			arr += _find_all_spinboxes(c)
	return arr
	
func _find_all_richtext(node: Node) -> Array[RichTextLabel]:
	var arr: Array[RichTextLabel] = []
	for c in node.get_children():
		if c is RichTextLabel:
			arr.append(c)
		else:
			arr += _find_all_richtext(c)
	return arr


func fold_lines_soft(lines: Array[String], width: int) -> Array[String]:
	var result: Array[String] = []

	for original_line in lines:
		var words := original_line.split(" ")
		var current_line := ""

		for word in words:
			var extra := (1 if current_line != "" else 0) + word.length()
			if current_line.length() + extra > width:
				result.append(current_line)
				current_line = word
			else:
				if current_line == "":
					current_line = word
				else:
					current_line += " " + word

		if current_line != "":
			result.append(current_line)

	return result
