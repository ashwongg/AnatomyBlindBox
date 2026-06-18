extends Control

func _ready() -> void: 
	$Label.text = "Tokens: " +str(GlobalVariables.tokens)
	# Connect each button to the SAME function, but bind a unique string to each
	$Play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/quiz.tscn"))
	$Blind_Box.pressed.connect(_on_change_scene_requested.bind("res://Scenes/blind_box.tscn"))
	$Credits.pressed.connect(_on_change_scene_requested.bind("res://Scenes/Credits.tscn"))
	$How_to_play.pressed.connect(_on_change_scene_requested.bind("res://Scenes/HowToPlay.tscn"))

func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)
