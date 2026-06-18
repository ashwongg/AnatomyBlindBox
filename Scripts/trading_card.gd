extends Control

@onready var popup = $Window 

# 1. Load the textures once at the start
#Heart
@onready var basic_heart = preload("res://Assets/Trading Cards/F_Basic_Heart.png")
@onready var rare_heart = preload("res://Assets/Trading Cards/F_Rare_Heart.png")
#Lungs
@onready var front_lung = preload("res://Assets/Trading Cards/F_Basic_Lung.png")
@onready var back_lung = preload("res://Assets/Trading Cards/B_Basic_Lung.png")
#Brain
@onready var basic_brain = preload("res://Assets/Trading Cards/F_Basic_Brain.png")
@onready var rare_brain = preload("res://Assets/Trading Cards/F_Rare_Brain.png")
#Liver
@onready var front_liver = preload("res://Assets/Trading Cards/F_Basic_Liver.png")
@onready var back_liver = preload("res://Assets/Trading Cards/B_Basic_Liver.png")
#Kidney
@onready var front_kidney = preload("res://Assets/Trading Cards/F_Basic_Kidney.png")
@onready var back_kidney = preload("res://Assets/Trading Cards/B_Basic_Kidney.png")
#Stomach
@onready var front_stomach = preload("res://Assets/Trading Cards/F_Basic_Stomach.png")
@onready var back_stomach= preload("res://Assets/Trading Cards/B_Basic_Stomach.png")
#sm_intestine
@onready var front_sm_intestine = preload("res://Assets/Trading Cards/F_Basic_SmallIntestines.png")
@onready var back_sm_intestine = preload("res://Assets/Trading Cards/B_Basic_SmallIntestines.png")
#lrg_intestine 
@onready var front_lrg_intestine = preload("res://Assets/Trading Cards/F_Basic_LargeIntestine.png")
@onready var back_lrg_intestine = preload("res://Assets/Trading Cards/B_Basic_LargeIntestines.png")

# 2. These variables hold your nodes. 
@onready var heart_card = $HeartCard
@onready var rare_heartcard = $Rare_HeartCard
@onready var lung_card = $LungCard
@onready var brain_card = $BrainCard
@onready var rare_braincard = $Rare_BrainCard
@onready var liver_card =$Livercard
@onready var kidney_card = $KidneyCard
@onready var stomach_card = $StomachCard
@onready var sm_intestine_card = $Small_IntestineCard
@onready var lrg_intestine_card = $Large_IntestineCard

@onready var back_card = $Window/show_BackCard

func _ready():
	# Using the variable we made above instead of a hardcoded path
	if heart_card and GlobalVariables.has_heart:
		heart_card.texture_normal = basic_heart
	if rare_heartcard and GlobalVariables.has_rare_heart:
		rare_heartcard.texture_normal = rare_heart
	if lung_card and GlobalVariables.has_lungs:
		lung_card.texture_normal = front_lung
	if brain_card and GlobalVariables.has_brain:
		brain_card.texture_normal = basic_brain
	if rare_braincard and GlobalVariables.has_brain:
		rare_braincard.texture_normal = rare_brain
	if liver_card and GlobalVariables.has_liver:
		liver_card.texture_normal = front_liver
	if kidney_card and GlobalVariables.has_kidneys:
		kidney_card.texture_normal = front_kidney
	if stomach_card and GlobalVariables.has_stomach:
		stomach_card.texture_normal = front_stomach
	if sm_intestine_card and GlobalVariables.has_smallintestines:
		sm_intestine_card.texture_normal = front_sm_intestine
	if lrg_intestine_card and GlobalVariables.has_largeintestines:
		lrg_intestine_card.texture_normal = front_lrg_intestine	

func _on_window_close_requested():
	popup.hide()

func _on_show_back_card_pressed() -> void:
	popup.hide()

func _on_lung_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = back_lung
	
func _on_heart_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = basic_heart

func _on_rare_heart_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = rare_heart
	
func _on_brain_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = basic_brain
	
func _on_rare_brain_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = rare_brain
	
func _on_liver_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = back_liver

func _on_kidney_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = back_kidney
	
func _on_stomach_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = back_stomach
	
func _on_small_intestine_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = back_sm_intestine
	
func _on_large_intestine_card_pressed() -> void:
	popup.show()
	back_card.texture_normal = back_lrg_intestine

# Instead of connecting a signal inside a signal, we just change the scene immediately!
func _on_back_pressed() -> void:
	change_scene("res://Scenes/blind_box.tscn")

# A clean, reusable function to handle changing scenes safely
func change_scene(target_path: String) -> void:
	print("Switching to scene: ", target_path)
	var error = get_tree().change_scene_to_file(target_path)
	if error != OK:
		print("Failed to load scene! Check your file path: ", target_path)
