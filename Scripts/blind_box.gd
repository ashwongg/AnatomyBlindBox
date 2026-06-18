extends Control

@onready var popup2 = $You_Got 
@onready var openbox = $OpenBox
#Placeholder
@onready var placeholder_openbox = $spr_PlaceholderOpenBox
#Open Box Animations
@onready var heart_openbox = $spr_HeartOpenBox

@onready var show_prize = $You_Got/show_prize

#Images for Organs
@onready var get_Heart = preload("res://Assets/Trading Cards/F_Basic_Heart.png")
@onready var get_Brain = preload("res://Assets/Trading Cards/F_Basic_Brain.png")
@onready var get_Kidney = preload("res://Assets/You_Got/you_got_kidney.png")
@onready var get_Liver = preload("res://Assets/You_Got/you_got_liver.png")
@onready var get_SmIntestine = preload("res://Assets/You_Got/you_got_small_intestine.png")
@onready var get_LrgIntestine = preload("res://Assets/You_Got/you_got_large_intestine.png")
@onready var get_Stomach = preload("res://Assets/You_Got/you_got_stomach.png")
@onready var get_Lung = preload("res://Assets/You_Got/you_got_lungs.png")

#Images for RARE Organs
@onready var get_rare_Heart = preload("res://Assets/Trading Cards/F_Rare_Heart.png")
@onready var get_rare_Brain = preload("res://Assets/Trading Cards/F_Rare_Brain.png")
@onready var get_rare_Kidney = preload("res://Assets/You_Got/you_got_rare_kidneys.png")
@onready var get_rare_Liver = preload("res://Assets/You_Got/you_got_rare_liver.png")
@onready var get_rare_SmIntestine = preload("res://Assets/You_Got/you_got_rare_small_intestine.png")
@onready var get_rare_LrgIntestine = preload("res://Assets/You_Got/you_got_rare_large_intestine.png")
@onready var get_rare_Stomach = preload("res://Assets/You_Got/you_got_rare_stomach.png")
@onready var get_rare_Lung = preload("res://Assets/You_Got/you_got_rare_lungs.png")

var rng = RandomNumberGenerator.new()

func _ready() -> void: 
	rng.randomize()
	$Label.text = "Cells: " +str(GlobalVariables.tokens)
	# Connect each button to the SAME function, but bind a unique string to each
	$Menu.pressed.connect(_on_change_scene_requested.bind("res://Scenes/main.tscn"))
	$Cards.pressed.connect(_on_change_scene_requested.bind("res://Scenes/TradingCard.tscn"))
	$visitSkelly.pressed.connect(_on_change_scene_requested.bind("res://Scenes/VisitSkelly.tscn"))


func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)


func _on_open_box_pressed() -> void:
	if GlobalVariables.tokens > 0: 
		GlobalVariables.tokens -= 1 
		$Label.text = "Cells: " + str(GlobalVariables.tokens)
		var random_blindbox = rng.randi_range(1, 4)
		
		match random_blindbox:
			1:	
				$spr_PlaceholderOpenBox.show()
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$spr_PlaceholderOpenBox.hide()
				$You_Got.show()
				GlobalVariables.has_brain = true 
				show_prize.texture_normal = get_Brain
			2:
				$spr_HeartOpenBox.show()
				heart_openbox.frame = 0 # Force the animation back to the start
				heart_openbox.play()
				await heart_openbox.animation_finished
				print("animation finished")
				$spr_HeartOpenBox.hide()
				$You_Got.show()
				GlobalVariables.has_heart = true 
				show_prize.texture_normal = get_Heart
			3:
				$spr_PlaceholderOpenBox.show()
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()
				#temp
				GlobalVariables.has_rare_heart = true 
				show_prize.texture_normal = get_rare_Heart
				$spr_PlaceholderOpenBox.hide()
				#GlobalVariables.has_kidneys = true 
				#show_prize.texture_normal = get_Kidney
			4:
				$spr_PlaceholderOpenBox.show()
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()
				#temp
				GlobalVariables.has_rare_brain = true 
				show_prize.texture_normal = get_rare_Brain
				$spr_PlaceholderOpenBox.hide()
				#GlobalVariables.has_liver = true 
				#show_prize.texture_normal = get_Liver
			5:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()
				GlobalVariables.has_largeintestines = true 
				show_prize.texture_normal = get_LrgIntestine
			6:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()
				GlobalVariables.has_smallintestines = true 
				show_prize.texture_normal = get_SmIntestine
			7:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()
				GlobalVariables.has_lungs = true 
				show_prize.texture_normal = get_Lung
			8:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_stomach = true 
				show_prize.texture_normal = get_Stomach
				
			# Rare Organs
			9:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()
				GlobalVariables.has_rare_brain = true 
				show_prize.texture_normal = get_rare_Brain
			10:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_rare_heart = true 
				show_prize.texture_normal = get_rare_Heart
			11:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_rare_kidneys = true 
				show_prize.texture_normal = get_rare_Kidney
			12:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_rare_liver = true 
				show_prize.texture_normal = get_rare_Liver
			13:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_rare_largeintestines = true 
				show_prize.texture_normal = get_rare_LrgIntestine
			14:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_rare_smallintestines = true 
				show_prize.texture_normal = get_rare_SmIntestine
			15:
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_lungs = true 
				show_prize.texture_normal = get_Lung
			_: # The underscore acts as the 'else' (default) case
				placeholder_openbox.frame = 0 # Force the animation back to the start
				placeholder_openbox.play()
				await placeholder_openbox.animation_finished
				print("animation finished")
				$You_Got.show()				
				GlobalVariables.has_rare_stomach = true 
				show_prize.texture_normal = get_rare_Stomach
	
func _on_show_prize_pressed() -> void:
	popup2.hide()
