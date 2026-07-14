extends Control

# Define the speed/duration of the slide in seconds
@export var slide_duration: float = 0.5



func _ready():
	# 1. Preload the scenes at the top of the file so they sit in RAM ready to go
	ResourceLoader.load_threaded_request("res://Scenes/blind_box.tscn")
	ResourceLoader.load_threaded_request("res://Scenes/VisitSkelly_rare.tscn")
	
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
		
	# Correctly connect the signal without the faulty 'if' check
	# We pass DISCO_SCENE directly to the updated function
	# Move your preloads to the top level so the entire script can access them if needed
	$Back.pressed.connect(_on_change_scene_requested.bind("res://Scenes/blind_box.tscn"))
	$disco.pressed.connect(_on_change_scene_requested.bind("res://Scenes/VisitSkelly_rare.tscn"))

# Changed 'target' type from String to PackedScene
# Change 'target' type from PackedScene to String
func _on_change_scene_requested(target_path: String) -> void:
	if target_path == "":
		return
		
	# 3. Retrieve the fully loaded asset from the background thread instantly
	var target_scene = ResourceLoader.load_threaded_get(target_path) as PackedScene
	
	if target_scene != null and target_scene.can_instantiate():
		get_tree().change_scene_to_packed(target_scene)
	else:
		print("Error: Background asset wasn't ready or failed to load.")

# Helper function to smoothly animate any node to a target position
func slide_node_to(node: Control, target_pos: Vector2) -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "position", target_pos, slide_duration)

func _on_brain_pressed() -> void:
	slide_node_to($brain, Vector2(313, 32))

func _on_heart_pressed() -> void:
	slide_node_to($heart, Vector2(309, 337))
	
func _on_liver_pressed() -> void:
	slide_node_to($liver, Vector2(323, 411))

func _on_kidneys_pressed() -> void:
	slide_node_to($R_Kidney, Vector2(426, 507))
	slide_node_to($L_Kidney, Vector2(281, 515))

func _on_sm_intestine_pressed() -> void:
	slide_node_to($"small intestine", Vector2(324, 505))
	
func _on_lrg_intestine_pressed() -> void:
	slide_node_to($"large intestine", Vector2(299, 497))
	
func _on_stomach_pressed() -> void:
	slide_node_to($stomach, Vector2(345, 412))
	
func _on_lung_pressed() -> void:
	slide_node_to($lungs, Vector2(291,346))
	
func _on_rib_cage_focus_entered() -> void:
	$"rib cage".self_modulate.a = 0

func _on_rib_cage_focus_exited() -> void:
	$"rib cage".self_modulate.a = 1
