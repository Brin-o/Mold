extends Node

# Drag your Theme resource into this from the inspector (or preload).
@export var ui_theme: Theme

func _ready():
	# Example: if you have a SpinBox child named "SpinBox"
	var sb = self
	# update visuals initially
	_update_spinbox_disabled_style(sb)

# Call this whenever you change the SpinBox.disabled or SpinBox.editable state
func _update_spinbox_disabled_style(spinbox: SpinBox) -> void:
	# get the internal LineEdit
	var le = spinbox.get_line_edit()
	if not le:
		return

	# if the spinbox is disabled (or not editable) apply the disabled style
	if not spinbox.editable:
		# get our theme stylebox by the name we created
		var disabled_box = ui_theme.get_stylebox("normal_disabled", "LineEdit")
		if disabled_box:
			# override LineEdit's "normal" stylebox so it looks disabled
			le.add_theme_stylebox_override("normal", disabled_box)
			# optional: dim entire control slightly too
			spinbox.modulate = Color(1,1,1,0.9)
	else:
		# remove the override -> fall back to theme's normal stylebox
		le.remove_theme_stylebox_override("normal")
		spinbox.modulate = Color(1,1,1,1)
