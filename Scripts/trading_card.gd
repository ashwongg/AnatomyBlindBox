extends Control

@onready var back_card = $show_BackCard
@onready var back = $Back

# 1. Load the textures once
@onready var missing = preload("res://Assets/Trading Cards/missing.png")

# Define all card data dynamically in a configuration dictionary
# Format: NodeName = ["GlobalVariable_Property", "Texture_Path", "Card_Display_Name"]
const CARD_DATA = {
	"HeartCard": ["has_heart", "res://Assets/Trading Cards/F_Basic_Heart.png", "Heart"],
	"Rare_HeartCard": ["has_rare_heart", "res://Assets/Trading Cards/F_Rare_Heart.png", "Rare Heart"],
	"LungCard": ["has_lungs", "res://Assets/Trading Cards/F_Basic_Lung.png", "Lung"],
	"Rare_LungCard": ["has_rare_lungs", "res://Assets/Trading Cards/F_Rare_Lung.png", "Rare Lung"],
	"BrainCard": ["has_brain", "res://Assets/Trading Cards/F_Basic_Brain.png", "Brain"],
	"Rare_BrainCard": ["has_rare_brain", "res://Assets/Trading Cards/F_Rare_Brain.png", "Rare Brain"],
	"Livercard": ["has_liver", "res://Assets/Trading Cards/F_Basic_Liver.png", "Liver"],
	"Rare_LiverCard": ["has_rare_liver", "res://Assets/Trading Cards/F_Rare_Liver.png", "Rare Liver"],
	"KidneyCard": ["has_kidneys", "res://Assets/Trading Cards/F_Basic_Kidney.png", "Kidney"],
	"Rare_KidneyCard": ["has_rare_kidneys", "res://Assets/Trading Cards/F_Rare_Kidney.png", "Rare Kidney"],
	"StomachCard": ["has_stomach", "res://Assets/Trading Cards/F_Basic_Stomach.png", "Stomach"],
	"Rare_StomachCard": ["has_rare_stomach", "res://Assets/Trading Cards/F_Rare_Stomach.png", "Rare Stomach"],
	"Small_IntestineCard": ["has_smallintestines", "res://Assets/Trading Cards/F_Basic_SmallIntestines.png", "Small Intestine"],
	"Rare_Small_IntestineCard": ["has_rare_smallintestines", "res://Assets/Trading Cards/F_Rare_SmallIntestines.png", "Rare Small Intestine"],
	"Large_IntestineCard": ["has_largeintestines", "res://Assets/Trading Cards/F_Basic_LargeIntestine.png", "Large Intestine"],
	"Rare_Large_IntestineCard": ["has_rare_largeintestines", "res://Assets/Trading Cards/F_Rare_LargeIntestine.png", "Rare Large Intestine"]
}

func _ready() -> void:
	# Connect back buttons cleanly
	$Back.pressed.connect(change_scene.bind("res://Scenes/blind_box.tscn"))
	back_card.pressed.connect(func(): back_card.hide())
	
	# Loop through every card setup dynamically
	for node_name in CARD_DATA:
		var card_node = get_node_or_null(node_name) as TextureButton
		if not card_node:
			continue # Skips if you misspelled a node name in the scene tree
			
		var global_var_name = CARD_DATA[node_name][0]
		var texture_path = CARD_DATA[node_name][1]
		var card_display_name = CARD_DATA[node_name][2]
		
		# Check if player has it. If true, load texture; if false, use missing.
		var is_unlocked: bool = GlobalVariables.get(global_var_name)
		var actual_texture = load(texture_path) if is_unlocked else missing
		
		# Apply texture to the board
		card_node.texture_normal = actual_texture
		
		# Connect the press event directly, passing down its specific data!
		card_node.pressed.connect(_on_card_pressed.bind(actual_texture, card_display_name))


# This replaces ALL 16 separate card press functions!
func _on_card_pressed(assigned_texture: Texture, card_name: String) -> void:
	print("Showed ", card_name, " card")
	back_card.texture_normal = assigned_texture
	back_card.show()


func change_scene(target_path: String) -> void:
	print("Switching to scene: ", target_path)
	var error = get_tree().change_scene_to_file(target_path)
	if error != OK:
		print("Failed to load scene! Check your file path: ", target_path)
