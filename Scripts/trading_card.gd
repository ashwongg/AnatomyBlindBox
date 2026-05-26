extends Control

@onready var popup = $Window 

# 1. Load the textures once at the start
@onready var front_lung = preload("res://Assets/Trading Cards/F_Lung.png")
@onready var back_lung = preload("res://Assets/Trading Cards/B_Lung.png")

# 2. These variables hold your nodes. 
@onready var lung_card = $LungCard
@onready var show_lung_card = $Window/show_LungCard

func _ready():
	# Using the variable we made above instead of a hardcoded path
	if lung_card:
		lung_card.texture_normal = front_lung

func _on_window_close_requested():
	popup.hide()

func _on_lung_card_pressed() -> void:
	popup.show()
	show_lung_card.texture_normal = back_lung

func _on_show_lung_card_pressed() -> void:
	popup.hide()


# Instead of connecting a signal inside a signal, we just change the scene immediately!
func _on_back_pressed() -> void:
	change_scene("res://Scenes/blind_box.tscn")

# A clean, reusable function to handle changing scenes safely
func change_scene(target_path: String) -> void:
	print("Switching to scene: ", target_path)
	var error = get_tree().change_scene_to_file(target_path)
	if error != OK:
		print("Failed to load scene! Check your file path: ", target_path)
