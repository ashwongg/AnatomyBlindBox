extends Control



# 2. These variables hold your nodes. 

func _on_rib_cage_focus_entered() -> void:
	$"rib cage".self_modulate.a = 0.1


func _on_rib_cage_focus_exited() -> void:
	$"rib cage".self_modulate.a = 1

	
func _ready():
	$Back.pressed.connect(_on_change_scene_requested.bind("res://Scenes/blind_box.tscn"))
	if GlobalVariables.has_lungs:
		$lungs.visible = true
	if GlobalVariables.has_brain:
		$brain.visible = true
	if GlobalVariables.has_largeintestines:
		$"large intestine".visible = true
	if GlobalVariables.has_smallintestines:
		$"small intestine".visible = true
	if GlobalVariables.has_kidneys:
		$L_Kidney.visible = true
		$R_Kidney.visible = true
	if GlobalVariables.has_liver:
		$liver.visible = true
	if GlobalVariables.has_heart:
		$heart.visible = true
	if GlobalVariables.has_stomach:
		$stomach.visible = true

func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)
