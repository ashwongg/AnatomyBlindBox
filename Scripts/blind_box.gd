extends Control

@onready var popup2 = $You_Got 
@onready var openbox = $OpenBox
@onready var placeholder_openbox = $spr_PlaceholderOpenBox
@onready var heart_openbox = $spr_HeartOpenBox
@onready var show_prize = $You_Got/show_prize

# We can store the reward data cleanly in a Dictionary structure
var rewards = {
	1:  {"global_var": "has_brain", "texture": "res://Assets/Trading Cards/F_Basic_Heart.png", "is_heart": false}, # Wait, your original code assigned get_Brain here but set_Heart texture? Double check your paths!
	2:  {"global_var": "has_heart", "texture": "res://Assets/Trading Cards/F_Basic_Heart.png", "is_heart": true},
	3:  {"global_var": "has_kidneys", "texture": "res://Assets/Trading Cards/F_Basic_Kidney.png", "is_heart": false},
	4:  {"global_var": "has_liver", "texture": "res://Assets/Trading Cards/F_Basic_Liver.png", "is_heart": false},
	5:  {"global_var": "has_largeintestines", "texture": "res://Assets/Trading Cards/F_Basic_LargeIntestine.png", "is_heart": false},
	6:  {"global_var": "has_smallintestines", "texture": "res://Assets/Trading Cards/F_Basic_SmallIntestines.png", "is_heart": false},
	7:  {"global_var": "has_lungs", "texture": "res://Assets/Trading Cards/F_Basic_Lung.png", "is_heart": false},
	8:  {"global_var": "has_stomach", "texture": "res://Assets/Trading Cards/F_Basic_Stomach.png", "is_heart": false},
	# Rare Organs
	9:  {"global_var": "has_rare_brain", "texture": "res://Assets/Trading Cards/F_Rare_Brain.png", "is_heart": false},
	10: {"global_var": "has_rare_heart", "texture": "res://Assets/Trading Cards/F_Rare_Heart.png", "is_heart": false},
	11: {"global_var": "has_rare_kidneys", "texture": "res://Assets/Trading Cards/F_Rare_Kidney.png", "is_heart": false},
	12: {"global_var": "has_rare_liver", "texture": "res://Assets/Trading Cards/F_Rare_Liver.png", "is_heart": false},
	13: {"global_var": "has_rare_largeintestines", "texture": "res://Assets/Trading Cards/F_Rare_LargeIntestine.png", "is_heart": false},
	14: {"global_var": "has_rare_smallintestines", "texture": "res://Assets/Trading Cards/F_Rare_SmallIntestines.png", "is_heart": false},
	15: {"global_var": "has_rare_lungs", "texture": "res://Assets/Trading Cards/F_Rare_Lung.png", "is_heart": false},
	16: {"global_var": "has_rare_stomach", "texture": "res://Assets/Trading Cards/F_Rare_Stomach.png", "is_heart": false}
}

var rng = RandomNumberGenerator.new()

func _ready() -> void: 
	rng.randomize()
	$Label.text = "Cells: " + str(GlobalVariables.tokens)
	$Menu.pressed.connect(_on_change_scene_requested.bind("res://Scenes/main.tscn"))
	$Cards.pressed.connect(_on_change_scene_requested.bind("res://Scenes/TradingCard.tscn"))
	$visitSkelly.pressed.connect(_on_change_scene_requested.bind("res://Scenes/VisitSkelly.tscn"))


func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		get_tree().change_scene_to_file(target)


func _on_open_box_pressed() -> void:
	if GlobalVariables.tokens <= 0: 
		return # Stop execution early if they don't have enough tokens
		
	GlobalVariables.tokens -= 1 
	$Label.text = "Cells: " + str(GlobalVariables.tokens)
	
	var roll = rng.randi_range(1, 16)
	var prize_data = rewards[roll]
	
	# Determine which sprite node to play based on the reward data
	var active_anim = heart_openbox if prize_data["is_heart"] else placeholder_openbox
	
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
	
	# Load and apply texture dynamically
	show_prize.texture_normal = load(prize_data["texture"])
	$You_Got.show()


func _on_show_prize_pressed() -> void:
	popup2.hide()
