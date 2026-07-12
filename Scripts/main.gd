extends Control

func _ready() -> void: 
	$Label.text = "Tokens: " + str(GlobalVariables.tokens)
	
	# Connect the Play button based on cutscene status
	if not GlobalVariables.played_intro_cutscene: 
		$Play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/intro_video.tscn"))
	else: 
		$Play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/quiz.tscn"))
	
	# Connect all other buttons right at the start
	$Blind_Box.pressed.connect(_on_change_scene_requested.bind("res://Scenes/blind_box.tscn"))
	$Credits.pressed.connect(_on_change_scene_requested.bind("res://Scenes/Credits.tscn"))
	$How_to_play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/HowToPlay.tscn"))
	
	# FIX: Connect the Movie button here so it works on the very first click!
	$Movie.pressed.connect(_on_change_scene_requested.bind("res://Scenes/intro_video.tscn"))


func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)
