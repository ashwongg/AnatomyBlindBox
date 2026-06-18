extends Control



@onready var skelly_lungs = preload("res://Assets/Skelly Organs/lungs.png")
# 2. These variables hold your nodes. 

	
func _ready():
	$Back.pressed.connect(_on_change_scene_requested.bind("res://Scenes/blind_box.tscn"))
	if GlobalVariables.has_lungs:
		$lungs.visible = true

func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)
