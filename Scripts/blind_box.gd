extends Control

@onready var popup2 = $You_Got 
@onready var openbox = $OpenBox

@onready var placeholder_openbox = $spr_PlaceholderOpenBox

@onready var heart_openbox = $spr_HeartOpenBox_Common
@onready var brain_openbox = $spr_BrainOpenBox_Common
@onready var kidney_openbox = $spr_KidneyOpenBox_Common
@onready var liver_openbox = $spr_LiverOpenBox_Common
@onready var lungs_openbox = $spr_LungsOpenBox_Common
@onready var sml_intestine_openbox = $spr_SmlIntesOpenBox_Common
@onready var lrg_intestine_openbox = $spr_LrgIntesOpenBox_Common
@onready var stomach_openbox = $spr_StomachOpenBox_Common

@onready var heart_openbox_rare = $spr_HeartOpenBox_Rare
@onready var brain_openbox_rare = $spr_BrainOpenBox_Rare
@onready var kidney_openbox_rare = $spr_KidneyOpenBox_Rare
@onready var liver_openbox_rare = $spr_LiverOpenBox_Rare
@onready var lungs_openbox_rare = $spr_LungsOpenBox_Rare
@onready var sml_intestine_openbox_rare = $spr_SmlIntesOpenBox_Rare
@onready var lrg_intestine_openbox_rare = $spr_LrgIntesOpenBox_Rare
@onready var stomach_openbox_rare = $spr_StomachOpenBox_Rare

@onready var show_prize = $You_Got/show_prize

# We can store the reward data cleanly in a Dictionary structure
# Add @onready here so it can reference the sprite nodes below
@onready var rewards = {
	1:  {"node": brain_openbox, "global_var": "has_brain", "texture": "res://Assets/Trading Cards/F_Basic_Heart.png"},
	2:  {"node": heart_openbox, "global_var": "has_heart", "texture": "res://Assets/Trading Cards/F_Basic_Heart.png"},
	3:  {"node": kidney_openbox, "global_var": "has_kidneys", "texture": "res://Assets/Trading Cards/F_Basic_Kidney.png"},
	4:  {"node": liver_openbox, "global_var": "has_liver", "texture": "res://Assets/Trading Cards/F_Basic_Liver.png"},
	5:  {"node": lrg_intestine_openbox, "global_var": "has_largeintestines", "texture": "res://Assets/Trading Cards/F_Basic_LargeIntestine.png"},
	6:  {"node": sml_intestine_openbox, "global_var": "has_smallintestines", "texture": "res://Assets/Trading Cards/F_Basic_SmallIntestines.png"},
	7:  {"node": lungs_openbox, "global_var": "has_lungs", "texture": "res://Assets/Trading Cards/F_Basic_Lung.png"},
	8:  {"node": stomach_openbox, "global_var": "has_stomach", "texture": "res://Assets/Trading Cards/F_Basic_Stomach.png"},
	# Rare Organs
	9:  {"node": brain_openbox_rare, "global_var": "has_rare_brain", "texture": "res://Assets/Trading Cards/F_Rare_Brain.png"},
	10: {"node": heart_openbox_rare, "global_var": "has_rare_heart", "texture": "res://Assets/Trading Cards/F_Rare_Heart.png"},
	11: {"node": kidney_openbox_rare, "global_var": "has_rare_kidneys", "texture": "res://Assets/Trading Cards/F_Rare_Kidney.png"},
	12: {"node": liver_openbox_rare, "global_var": "has_rare_liver", "texture": "res://Assets/Trading Cards/F_Rare_Liver.png"},
	13: {"node": lrg_intestine_openbox_rare, "global_var": "has_rare_largeintestines", "texture": "res://Assets/Trading Cards/F_Rare_LargeIntestine.png"},
	14: {"node": sml_intestine_openbox_rare, "global_var": "has_rare_smallintestines", "texture": "res://Assets/Trading Cards/F_Rare_SmallIntestines.png"},
	15: {"node": lungs_openbox_rare, "global_var": "has_rare_lungs", "texture": "res://Assets/Trading Cards/F_Rare_Lung.png"},
	16: {"node": stomach_openbox_rare, "global_var": "has_rare_stomach", "texture": "res://Assets/Trading Cards/F_Rare_Stomach.png"}
}

var rng = RandomNumberGenerator.new()

func _ready() -> void: 
	rng.randomize()
	$Label.text = " : " + str(GlobalVariables.tokens)
	$Menu.pressed.connect(_on_change_scene_requested.bind("res://Scenes/main.tscn"))
	$Cards.pressed.connect(_on_change_scene_requested.bind("res://Scenes/TradingCard.tscn"))
	$visitSkelly.pressed.connect(_on_change_scene_requested.bind("res://Scenes/VisitSkelly.tscn"))


func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		get_tree().change_scene_to_file(target)


func _on_open_box_pressed() -> void:
	$OpenBox.hide()
	if GlobalVariables.tokens <= 0: 
		return # Stop execution early if they don't have enough tokens
		
	GlobalVariables.tokens -= 1 
	$Label.text = " : " + str(GlobalVariables.tokens)
	
	var roll = rng.randi_range(1, 16)
	var prize_data = rewards[roll]
	
	# Determine which sprite node to play based on the reward data
	var active_anim = prize_data["node"]
	
	# Safeguard: Ensure the animations start clean
	placeholder_openbox.hide()
	heart_openbox.hide()
	
	active_anim.show()
	active_anim.stop() # Reset the animation player state completely
	active_anim.frame = 0 
	active_anim.play()
	
	# Wait for animation to finish
	await active_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	
	active_anim.hide()
	
	# Dynamically set the Global variable flag using set()
	GlobalVariables.set(prize_data["global_var"], true)
	
	if GlobalVariables.has_brain and GlobalVariables.has_heart and GlobalVariables.has_kidneys and GlobalVariables.has_lungs and GlobalVariables.has_stomach and GlobalVariables.has_largeintestines and GlobalVariables.has_smallintestines and GlobalVariables.has_liver: 
		GlobalVariables.all_common_organs_collected = true 
		
	
	# Load and apply texture dynamically
	show_prize.texture_normal = load(prize_data["texture"])
	$You_Got.show()


func _on_show_prize_pressed() -> void:
	$OpenBox.show()
	popup2.hide()
