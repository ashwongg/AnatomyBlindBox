extends Control

@onready var back_card = $show_BackCard

@onready var back = $Back

# 1. Load the textures once at the start
#Heart
@onready var basic_heart = preload("res://Assets/Trading Cards/F_Basic_Heart.png")
@onready var rare_heart = preload("res://Assets/Trading Cards/F_Rare_Heart.png")
#Lungs
@onready var basic_lung = preload("res://Assets/Trading Cards/F_Basic_Lung.png")
@onready var rare_lung = preload("res://Assets/Trading Cards/F_Rare_Lung.png")
#Brain
@onready var basic_brain = preload("res://Assets/Trading Cards/F_Basic_Brain.png")
@onready var rare_brain = preload("res://Assets/Trading Cards/F_Rare_Brain.png")
#Liver
@onready var basic_liver = preload("res://Assets/Trading Cards/F_Basic_Liver.png")
@onready var rare_liver = preload("res://Assets/Trading Cards/F_Rare_Liver.png")
#Kidney
@onready var basic_kidney = preload("res://Assets/Trading Cards/F_Basic_Kidney.png")
@onready var rare_kidney = preload("res://Assets/Trading Cards/F_Rare_Kidney.png")
#Stomach
@onready var basic_stomach = preload("res://Assets/Trading Cards/F_Basic_Stomach.png")
@onready var rare_stomach= preload("res://Assets/Trading Cards/F_Rare_Stomach.png")
#sm_intestine
@onready var basic_sm_intestine = preload("res://Assets/Trading Cards/F_Basic_SmallIntestines.png")
@onready var rare_sm_intestine = preload("res://Assets/Trading Cards/F_Rare_SmallIntestines.png")
#lrg_intestine 
@onready var basic_lrg_intestine = preload("res://Assets/Trading Cards/F_Basic_LargeIntestine.png")
@onready var rare_lrg_intestine = preload("res://Assets/Trading Cards/F_Rare_LargeIntestine.png")

# 2. These variables hold your nodes. 
@onready var heart_card = $HeartCard
@onready var rare_heartcard = $Rare_HeartCard
@onready var lung_card = $LungCard
@onready var rare_lungcard = $Rare_LungCard
@onready var brain_card = $BrainCard
@onready var rare_braincard = $Rare_BrainCard
@onready var liver_card = $Livercard
@onready var rare_livercard = $Rare_LiverCard
@onready var kidney_card = $KidneyCard
@onready var rare_kidneycard = $Rare_KidneyCard
@onready var stomach_card = $StomachCard
@onready var rare_stomachcard = $Rare_StomachCard
@onready var sm_intestine_card = $Small_IntestineCard
@onready var rare_sm_intestinecard = $Rare_Small_IntestineCard
@onready var lrg_intestine_card = $Large_IntestineCard
@onready var rare_lrg_intestinecard = $Rare_Large_IntestineCard



func _ready():
	# Using the variable we made above instead of a hardcoded path
	if heart_card and GlobalVariables.has_heart:
		heart_card.texture_normal = basic_heart
	if rare_heartcard and GlobalVariables.has_rare_heart:
		rare_heartcard.texture_normal = rare_heart
	if lung_card and GlobalVariables.has_lungs:
		lung_card.texture_normal = basic_lung
	if rare_lungcard and GlobalVariables.has_rare_lungs:
		rare_lungcard.texture_normal = rare_lung
	if brain_card and GlobalVariables.has_brain:
		brain_card.texture_normal = basic_brain
	if rare_braincard and GlobalVariables.has_rare_brain:
		rare_braincard.texture_normal = rare_brain
	if liver_card and GlobalVariables.has_liver:
		liver_card.texture_normal = basic_liver
	if rare_livercard and GlobalVariables.has_rare_liver:
		rare_livercard.texture_normal = rare_liver
	if kidney_card and GlobalVariables.has_kidneys:
		kidney_card.texture_normal = basic_kidney
	if rare_kidneycard and GlobalVariables.has_rare_kidneys:
		rare_kidneycard.texture_normal = rare_kidney
	if stomach_card and GlobalVariables.has_stomach:
		stomach_card.texture_normal = basic_stomach
	if rare_stomachcard and GlobalVariables.has_rare_stomach:
		rare_stomachcard.texture_normal = rare_stomach
	if sm_intestine_card and GlobalVariables.has_smallintestines:
		sm_intestine_card.texture_normal = basic_sm_intestine
	if rare_sm_intestinecard and GlobalVariables.has_rare_smallintestines:
		rare_sm_intestinecard.texture_normal = rare_sm_intestine
	if lrg_intestine_card and GlobalVariables.has_largeintestines:
		lrg_intestine_card.texture_normal = basic_lrg_intestine	
	if rare_lrg_intestinecard and GlobalVariables.has_rare_largeintestines:
		rare_lrg_intestinecard.texture_normal = rare_lrg_intestine	


#---------------------------------------------------
func _on_lung_card_pressed() -> void:
	print("Showed Lung card")
	back_card.show()
	back_card.texture_normal = basic_lung
	
func _on_rare_lung_card_pressed() -> void:
	print("Showed Rare Lung card")
	back_card.show()
	back_card.texture_normal = rare_lung
#---------------------------------------------------
func _on_heart_card_pressed() -> void:
	print("Showed Heart card")
	back_card.show()
	back_card.texture_normal = basic_heart

func _on_rare_heart_card_pressed() -> void:
	print("Showed Rare Heart card")
	back_card.show()
	back_card.texture_normal = rare_heart
#---------------------------------------------------	
func _on_brain_card_pressed() -> void:
	print("Showed Brain Heart card")
	back_card.show()
	back_card.texture_normal = basic_brain
	
func _on_rare_brain_card_pressed() -> void:
	print("Showed Rare Brain Heart card")
	back_card.show()
	back_card.texture_normal = rare_brain
#---------------------------------------------------	
func _on_liver_card_pressed() -> void:
	print("Showed Liver Heart card")
	back_card.show()
	back_card.texture_normal = basic_liver

func _on_rare_liver_card_pressed() -> void:
	print("Showed Rare Liver Heart card")
	back_card.show()
	back_card.texture_normal = rare_liver
#---------------------------------------------------	
func _on_kidney_card_pressed() -> void:
	print("Showed Kidney Heart card")
	back_card.show()
	back_card.texture_normal = basic_kidney
	
func _on_rare_kidney_card_pressed() -> void:
	print("Showed Rare Kidney Heart card")
	back_card.show()
	back_card.texture_normal = rare_kidney
#---------------------------------------------------	
func _on_stomach_card_pressed() -> void:
	print("Showed Stomach Kidney Heart card")
	back_card.show()
	back_card.texture_normal = basic_stomach
	
func _on_rare_stomach_card_pressed() -> void:
	print("Showed Rare Stomach Kidney Heart card")
	back_card.show()
	back_card.texture_normal = rare_stomach
#---------------------------------------------------	
	
func _on_small_intestine_card_pressed() -> void:
	print("Showed Sm Intestine Heart card")
	back_card.show()
	back_card.texture_normal =  basic_sm_intestine

func _on_rare_small_intestine_card_pressed() -> void:
	print("Showed Rare Sm Intestine Heart card")
	back_card.show()
	back_card.texture_normal =  rare_sm_intestine	
#---------------------------------------------------	
func _on_large_intestine_card_pressed() -> void:
	print("Showed Lrg Intestine Heart card")
	back_card.show()
	back_card.texture_normal =  basic_lrg_intestine

func _on_rare_large_intestine_card_pressed() -> void:
	print("Showed Rare Lrg Intestine Heart card")
	back_card.show()	
	back_card.texture_normal =  rare_lrg_intestine
#---------------------------------------------------	

func _on_back_pressed() -> void:
	change_scene("res://Scenes/blind_box.tscn")
	
func _on_show_back_card_pressed() -> void:
	back_card.hide()
func change_scene(target_path: String) -> void:
	print("Switching to scene: ", target_path)
	var error = get_tree().change_scene_to_file(target_path)
	if error != OK:
		print("Failed to load scene! Check your file path: ", target_path)
