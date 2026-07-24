extends Control

@onready var popup2 = $You_Got 
@onready var openbox = $OpenBox
@onready var placeholder_openbox = $spr_PlaceholderOpenBox
@onready var idle_box = $spr_Idle_Box
@onready var show_prize = $You_Got/show_prize

# OPTIMIZATION: One single AnimatedSprite2D node to handle all 16 variations!
@onready var organ_opener: AnimatedSprite2D = $spr_OrganOpener

# Fast Runtime Scene Memory Variables
var trading_card_scene: PackedScene
var quiz_scene: PackedScene
var skelly_scene: PackedScene
var main_menu_scene: PackedScene

# Clear configuration mapping animation names instead of separate nodes
@onready var rewards = {
	1:  {"anim_name": "is_brain_basic", "global_var": "has_brain", "texture": "res://Assets/Trading Cards/F_Basic_Brain.png"},
	2:  {"anim_name": "is_heart_basic", "global_var": "has_heart", "texture": "res://Assets/Trading Cards/F_Basic_Heart.png"},
	3:  {"anim_name": "is_kidneys_basic", "global_var": "has_kidneys", "texture": "res://Assets/Trading Cards/F_Basic_Kidney.png"},
	4:  {"anim_name": "is_liver_basic", "global_var": "has_liver", "texture": "res://Assets/Trading Cards/F_Basic_Liver.png"},
	5:  {"anim_name": "is_lrgintestine_basic", "global_var": "has_largeintestines", "texture": "res://Assets/Trading Cards/F_Basic_LargeIntestine.png"},
	6:  {"anim_name": "is_smlintestine_basic", "global_var": "has_smallintestines", "texture": "res://Assets/Trading Cards/F_Basic_SmallIntestines.png"},
	7:  {"anim_name": "is_lungs_basic", "global_var": "has_lungs", "texture": "res://Assets/Trading Cards/F_Basic_Lung.png"},
	8:  {"anim_name": "is_stomach_basic", "global_var": "has_stomach", "texture": "res://Assets/Trading Cards/F_Basic_Stomach.png"},
	# Rare Organs
	9:  {"anim_name": "is_brain_rare", "global_var": "has_rare_brain", "texture": "res://Assets/Trading Cards/F_Rare_Brain.png"},
	10: {"anim_name": "is_heart_rare", "global_var": "has_rare_heart", "texture": "res://Assets/Trading Cards/F_Rare_Heart.png"},
	11: {"anim_name": "is_kidneys_rare", "global_var": "has_rare_kidneys", "texture": "res://Assets/Trading Cards/F_Rare_Kidney.png"},
	12: {"anim_name": "is_liver_rare", "global_var": "has_rare_liver", "texture": "res://Assets/Trading Cards/F_Rare_Liver.png"},
	13: {"anim_name": "is_lrgintestine_rare", "global_var": "has_rare_largeintestines", "texture": "res://Assets/Trading Cards/F_Rare_LargeIntestine.png"},
	14: {"anim_name": "is_smlintestine_rare", "global_var": "has_rare_smallintestines", "texture": "res://Assets/Trading Cards/F_Rare_SmallIntestines.png"},
	15: {"anim_name": "is_lungs_rare", "global_var": "has_rare_lungs", "texture": "res://Assets/Trading Cards/F_Rare_Lung.png"},
	16: {"anim_name": "is_stomach_rare", "global_var": "has_rare_stomach", "texture": "res://Assets/Trading Cards/F_Rare_Stomach.png"}
}
var rng = RandomNumberGenerator.new()

func _ready() -> void: 
	
	rng.randomize()
	$Label.text = " " + str(GlobalVariables.tokens)
	
	# Cache scenes into RAM immediately upon loading this menu
	trading_card_scene = load("res://Scenes/TradingCard.tscn")
	quiz_scene = load("res://Scenes/quiz.tscn")
	skelly_scene = load("res://Scenes/VisitSkelly.tscn")
	main_menu_scene = load("res://Scenes/main.tscn")
	
	# Clear connected dynamic scene button triggers
	$Menu.pressed.connect(_on_route_requested.bind("main"))
	$Cards.pressed.connect(_on_route_requested.bind("cards"))
	$visitSkelly.pressed.connect(_on_route_requested.bind("skelly"))
	$"Play Game".pressed.connect(_on_route_requested.bind("quiz"))
	
	# Prevent click focus lockouts on frame 1
	$OpenBox.focus_mode = Control.FOCUS_NONE
	$OpenBox.move_to_front() 
	$OpenBox.grab_click_focus()
	
	if GlobalVariables.played_ending_cutscene == true: 
		$closing_movie.visible = true

func _on_route_requested(destination: String) -> void:
	var target_packed: PackedScene = null
	match destination:
		"main": target_packed = main_menu_scene
		"cards": target_packed = trading_card_scene
		"skelly": target_packed = skelly_scene
		"quiz": target_packed = quiz_scene
		
	if target_packed != null:
		get_tree().change_scene_to_packed(target_packed)
	else:
		# Dynamic fallback route if resources weren't fully loaded
		var paths = {
			"main": "res://Scenes/main.tscn",
			"cards": "res://Scenes/TradingCard.tscn",
			"skelly": "res://Scenes/VisitSkelly.tscn",
			"quiz": "res://Scenes/quiz.tscn"
		}
		get_tree().change_scene_to_file(paths[destination])

func _on_open_box_pressed() -> void:
	if GlobalVariables.tokens <= 0: 
		$spr_Idle_Box.hide() 	
		$exchange.show()
		return
		
	$OpenBox.hide()
	$spr_Idle_Box.hide() 	
	GlobalVariables.tokens -= 1 
	$Label.text = " " + str(GlobalVariables.tokens)
	
	# Hide background elements cleanly
	$"Click to Open".visible = false 
	$"Play Game".visible = false 
	$Cards.visible = false 
	$visitSkelly.visible = false 
	$Menu.visible = false
	
	var roll = rng.randi_range(1, 16)
	var prize_data = rewards[roll]
	
	# Clear static placeholders
	placeholder_openbox.hide()
	
	# Configure single animator node to run specific target animation block
	organ_opener.show()
	organ_opener.stop()
	organ_opener.animation = prize_data["anim_name"]
	organ_opener.frame = 0 
	organ_opener.play()
	
	# Process layout timing sequences cleanly
	await organ_opener.animation_finished
	await get_tree().create_timer(1.0).timeout
	organ_opener.hide()
	
	# Flag global collections tracking lists
	GlobalVariables.set(prize_data["global_var"], true)
	
	# Check overall tier completions flags updates
	if GlobalVariables.has_brain and GlobalVariables.has_heart and GlobalVariables.has_kidneys and GlobalVariables.has_lungs and GlobalVariables.has_stomach and GlobalVariables.has_largeintestines and GlobalVariables.has_smallintestines and GlobalVariables.has_liver: 
		GlobalVariables.all_common_organs_collected = true
		if GlobalVariables.played_ending_cutscene == false: 
			GlobalVariables.played_ending_cutscene = true
			get_tree().change_scene_to_file("res://Scenes/closing_video.tscn")
	
	# Update prize graphics overlays windows layouts
	show_prize.texture_normal = load(prize_data["texture"])
	$You_Got.show()

func _on_show_prize_pressed() -> void:
	$OpenBox.show()
	$OpenBox.move_to_front()
	$spr_Idle_Box.show()
	$spr_Idle_Box.play("idle_box")
	
	popup2.hide()
	$"Click to Open".visible = true
	$"Play Game".visible = true 
	$Cards.visible = true 
	$visitSkelly.visible = true 
	$Menu.visible = true

func _on_closing_movie_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/closing_video.tscn")
