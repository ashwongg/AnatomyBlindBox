extends Control

@onready var popup = $Open_Box 
@onready var popup2 = $You_Got 
@onready var openbox = $Open_Box/OpenBox
@onready var anim_openbox = $Open_Box/spr_OpenBox
@onready var show_prize = $You_Got/show_prize

#Images for Organs
@onready var get_Heart = preload("res://Assets/You_Got/you_got_heart.png")
@onready var get_Brain = preload("res://Assets/You_Got/you_got_brain.png")
@onready var get_Kidney = preload("res://Assets/You_Got/you_got_kidney.png")
@onready var get_Liver = preload("res://Assets/You_Got/you_got_liver.png")
@onready var get_SmIntestine = preload("res://Assets/You_Got/you_got_small_intestine.png")
@onready var get_LrgIntestine = preload("res://Assets/You_Got/you_got_large_intestine.png")
@onready var get_Stomach = preload("res://Assets/You_Got/you_got_stomach.png")
@onready var get_Lung = preload("res://Assets/You_Got/you_got_lungs.png")

var rng = RandomNumberGenerator.new()

func _ready() -> void: 
	rng.randomize()
	$Label.text = "Tokens: " +str(GlobalVariables.tokens)
	# Connect each button to the SAME function, but bind a unique string to each
	$Menu.pressed.connect(_on_change_scene_requested.bind("res://Scenes/main.tscn"))
	$Cards.pressed.connect(_on_change_scene_requested.bind("res://Scenes/TradingCard.tscn"))

func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)


func _on_open_box_pressed() -> void:
	popup.show()
	anim_openbox.play()
	await anim_openbox.animation_finished
	print("animation finished")
	print("animation finished")
	$Open_Box.hide()
	$You_Got.show()
	var random_blindbox = rng.randi_range(1, 8)
	
	match random_blindbox:
		1:
			GlobalVariables.has_brain = true 
			show_prize.texture_normal = get_Brain
		2:
			GlobalVariables.has_heart = true 
			show_prize.texture_normal = get_Heart
		3:
			GlobalVariables.has_kidney = true 
			show_prize.texture_normal = get_Kidney
		4:
			GlobalVariables.has_liver = true 
			show_prize.texture_normal = get_Liver
		5:
			GlobalVariables.has_largeintestines = true 
			show_prize.texture_normal = get_LrgIntestine
		6:
			GlobalVariables.has_smallintestines = true 
			show_prize.texture_normal = get_SmIntestine
		7:
			GlobalVariables.has_lungs = true 
			show_prize.texture_normal = get_Lung
		_: # The underscore acts as the 'else' (default) case
			GlobalVariables.has_stomach = true 
			show_prize.texture_normal = get_Stomach

func _on_show_prize_pressed() -> void:
	popup2.hide()
