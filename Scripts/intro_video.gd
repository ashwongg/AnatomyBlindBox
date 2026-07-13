extends Control

# Drag and drop your images into this array in the Godot Inspector
@export var cutscene_images: Array[Texture2D] = []

# The file path to the next scene when the sequence finishes
@export_file("*.tscn") var next_scene_path: String = "res://Scenes/quiz.tscn"

@onready var cutscene_image: TextureRect = $CutsceneImage
@onready var advance_button: Button = $Next
@onready var back_button: Button = $Back

var current_index: int = 0

func _ready() -> void:
	# Safety check to make sure you added images
	if cutscene_images.is_empty():
		push_error("CRITICAL: No images added to the cutscene array!")
		return
		
	# Connect the button click to our advance function
	advance_button.pressed.connect(_on_advance_pressed)
	back_button.pressed.connect(_on_back_pressed)
	
	# Load the very first image right away
	display_current_image()


func display_current_image() -> void:
	if current_index < cutscene_images.size():
		cutscene_image.texture = cutscene_images[current_index]
	else:
		# If we somehow go out of bounds, safe-guard into the next scene
		load_next_scene()


func _on_advance_pressed() -> void:
	current_index += 1
	print(current_index)
	# Check if we have reached the end of the sequence
	if current_index >= cutscene_images.size():
		load_next_scene()
	else:
		display_current_image()

func _on_back_pressed() -> void:
	current_index -= 1
	print(current_index)
	# Check if we have reached the beginning of the sequence
	if current_index <= cutscene_images.size():
		cutscene_image.texture = cutscene_images[current_index]


func load_next_scene() -> void:
	if next_scene_path and next_scene_path != "":
		get_tree().change_scene_to_file(next_scene_path)
	else:
		push_error("ERROR: No next scene path specified in the Inspector!")
		
