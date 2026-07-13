extends Control

# Define the speed/duration of the slide in seconds
@export var slide_duration: float = 0.5

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

# Helper function to smoothly animate any node to a target position
func slide_node_to(node: Control, target_pos: Vector2) -> void:
	var tween = create_tween()
	# Uses TRANS_CUBIC and EASE_OUT for a snappy, smooth UI feeling
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	# Animates the "position" property over slide_duration
	tween.tween_property(node, "position", target_pos, slide_duration)


func _on_brain_pressed() -> void:
	slide_node_to($brain, Vector2(435, 32))

func _on_heart_pressed() -> void:
	slide_node_to($heart, Vector2(431, 337))
	
func _on_liver_pressed() -> void:
	slide_node_to($liver, Vector2(445, 411))

func _on_kidneys_pressed() -> void:
	slide_node_to($R_Kidney, Vector2(548, 507))
	slide_node_to($L_Kidney, Vector2(403, 515))

func _on_sm_intestine_pressed() -> void:
	slide_node_to($"small intestine", Vector2(456, 505))
	
func _on_lrg_intestine_pressed() -> void:
	slide_node_to($"large intestine", Vector2(421, 497.))
	
func _on_stomach_pressed() -> void:
	slide_node_to($stomach, Vector2(467, 412))
	
func _on_lung_pressed() -> void:
	slide_node_to($lungs, Vector2(413,346))
	
# --- Your existing hover logic ---
func _on_rib_cage_focus_entered() -> void:
	$"rib cage".self_modulate.a = 0

func _on_rib_cage_focus_exited() -> void:
	$"rib cage".self_modulate.a = 1
