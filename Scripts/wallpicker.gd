extends Control

const WALLPAPER_PATH := "res://Sprites/Wallpapers/"
const IMAGE_FORMATS := ["png", "jpg", "jpeg", "bmp", "webp"]

# Names that should use TILE mode
const TILE_NAMES := ["flowers", "noise", "purple", "trees"]
# Names that should use SCALE mode
const SCALE_NAMES := ["biochemistry", "chess", "tractor"]

func _ready():
	add_wallpapers_to_list()
	$Wallpaper/OptionButton.select(-1)


func add_wallpapers_to_list():
	var dir := DirAccess.open(WALLPAPER_PATH)
	if dir == null:
		printerr("Could not open folder in dir ... ", WALLPAPER_PATH)
		return

	var i := 0
	for file: String in dir.get_files():
		# Skip .import files
		if file.ends_with(".import"):
			continue

		var ext := file.get_extension().to_lower()
		if not IMAGE_FORMATS.has(ext):
			continue

		var display_name := file.get_file().get_basename()
		$Wallpaper/OptionButton.add_item(display_name, i)
		# Store the full filename (with extension) as metadata
		$Wallpaper/OptionButton.set_item_metadata(i, file)
		i += 1


func _on_button_button_down() -> void:
	set_wallpaper()


func set_wallpaper():
	var selected = $Wallpaper/OptionButton.selected
	if selected < 0:
		printerr("No wallpaper selected.")
		return

	# Prefer metadata (full filename), fall back to assuming .png
	var file_name = $Wallpaper/OptionButton.get_item_metadata(selected)
	if typeof(file_name) != TYPE_STRING or file_name == "":
		file_name = $Wallpaper/OptionButton.get_item_text(selected) + ".png"

	var selected_wall_path = WALLPAPER_PATH + file_name
	print("Trying to load wallpaper: ", selected_wall_path)

	## --- AUTO-SET STRETCH MODE OPTION BASED ON WALLPAPER NAME ---
	#_auto_set_stretch_mode_for_wallpaper(file_name)
	## ------------------------------------------------------------

	var bg_node: TextureRect = $"../../../BG"
	if bg_node == null:
		printerr("No BG node found.")
		return

	var tex: Texture2D = null

	# 1) Try as a resource (works in editor + exported builds)
	if ResourceLoader.exists(selected_wall_path):
		tex = load(selected_wall_path)
	else:
		# 2) Fallback: try as a file path (similar to your RichTextLabel script)
		var image := Image.load_from_file(selected_wall_path)
		if image != null:
			tex = ImageTexture.create_from_image(image)
		else:
			printerr("Failed to load wallpaper image from: ", selected_wall_path)
			return

	bg_node.texture = tex
	# Use whatever the Mode OptionButton is currently set to (we just auto-updated it)
	bg_node.stretch_mode = $Mode/OptionButton.selected


func _auto_set_stretch_mode_for_wallpaper(file_name: String) -> void:
	# Get base name like "flowers", "biochemistry" (no path, no extension)
	var base := file_name.get_file().get_basename().to_lower()
	var mode_button: OptionButton = $Mode/OptionButton

	var desired := ""  # "tile" or "scale"

	for name in TILE_NAMES:
		if base.find(name) != -1:
			desired = "tile"
			break

	if desired == "":
		for name in SCALE_NAMES:
			if base.find(name) != -1:
				desired = "scale"
				break

	# If no known matching name, do NOT change the option
	if desired == "":
		return

	# Find the correct option in the OptionButton
	var desired_idx := -1
	for i in range(mode_button.item_count):
		var txt := mode_button.get_item_text(i).to_lower()
		if desired == "tile" and txt.find("tile") != -1:
			desired_idx = i
			break
		if desired == "scale" and (txt.find("scale") != -1 or txt.find("stretch") != -1):
			desired_idx = i
			break

	# Only update the OptionButton selected option (no forcing!)
	if desired_idx != -1:
		mode_button.select(desired_idx)


func _on_wallpaper_button_item_selected(index: int) -> void:
	var wall = $Wallpaper/OptionButton.get_item_text(index)
	_auto_set_stretch_mode_for_wallpaper(wall)
