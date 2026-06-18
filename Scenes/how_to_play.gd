extends Control

func _ready() -> void: 

	$Back.pressed.connect(_on_change_scene_requested.bind("res://Scenes/main.tscn"))

func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)
