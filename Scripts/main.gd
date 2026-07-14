extends Control

# Preload the scene so it's already in memory
const BLIND_BOX_SCENE = preload("res://Scenes/blind_box.tscn")
@onready var unlock: Texture = load("res://Assets/unlock_all.png")
@onready var lock: Texture = load("res://Assets/lock_all.png")

func _ready() -> void: 

	# Connect the Play button based on cutscene status
	if not GlobalVariables.played_intro_cutscene: 
		$Play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/intro_video.tscn"))
	else: 
		$Play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/quiz.tscn"))
	
	# Change this connection to handle the preloaded packed scene instead of a path string
	$Blind_Box.pressed.connect(_on_blind_box_pressed)
	
	$Credits.pressed.connect(_on_change_scene_requested.bind("res://Scenes/Credits.tscn"))
	$How_to_play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/HowToPlay.tscn"))
	$Movie.pressed.connect(_on_change_scene_requested.bind("res://Scenes/intro_video.tscn"))
	
	if GlobalVariables.played_intro_cutscene == true: 
		$Movie.visible = true

func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)

# New dedicated function to handle the preloaded scene instantly
func _on_blind_box_pressed() -> void:
	print("Switching to blind box instantly...")
	get_tree().change_scene_to_packed(BLIND_BOX_SCENE)
	

func _on_unlock_all_pressed() -> void:
	if GlobalVariables.toggle == false: 
		$unlockALL.icon = lock
		$unlockALL/Label.text = "For testing - Locks All Organs"
		GlobalVariables.testing_true()
		GlobalVariables.toggle = true
		print("Turned toggle to true...")
	else: 
		GlobalVariables.toggle = false
		GlobalVariables.testing_false()
		$unlockALL.icon = unlock
		$unlockALL/Label.text = "For testing - Unlocks All Organs"
		print("Turned toggle to false...")
