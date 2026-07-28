extends Node2D 

@export var quiz_c: Question_collection
@export var color_right : Color
@export var color_wrong : Color 

var buttons : Array[Button] = []
var labels : Array[Label] = []

var index : int 
var correct: int

@onready var label_question: Label = $Control/MarginContainer/Label_Question
@onready var question: Node2D = $Control/Question
@onready var image: TextureRect = $Control/Image
@onready var skelly_happy: Texture = load("res://Assets/Skelly-right.png")
@onready var skelly_tryagain: Texture = load("res://Assets/Skelly-wrong.png")
@onready var quizzard_happy: Texture = load("res://Assets/Quizzard-happy.png")
@onready var quizzard_angry: Texture = load("res://Assets/Quizzard-angry.png")
@onready var skelly_help: Texture = load("res://Assets/help.png")
@onready var no_image: Texture = load("res://Assets/Questions_images/no_image.png")

@onready var sfx_right: AudioStreamPlayer = $SFXRight
@onready var sfx_wrong: AudioStreamPlayer = $SFXWrong

const BLIND_BOX_SCENE = preload("res://Scenes/blind_box.tscn")
@onready var back_button: Button = get_node_or_null("Back")

var shuffled_collection: Array = []

func _ready() -> void: 
	
	$BGMManager.stop()
	$BGMManager.stream = load("res://Music/tunetank-children-funny-music-348022.mp3")
	$BGMManager.play()
	
	if quiz_c == null:
		push_error("CRITICAL: You forgot to assign a Question_collection resource to quiz_c in the Inspector!")
		return
		

	shuffled_collection = quiz_c.collection.duplicate()
	shuffled_collection.shuffle()
	
	if back_button:
		$Back.pressed.connect(_on_change_scene_requested.bind(BLIND_BOX_SCENE))
	else:
		push_error("WARNING: Could not find a node named 'Back' in your scene root!")

	for b in question.get_children():
		if b is Button:
			buttons.append(b)
			
			# FIX: Connect the answer button permanently ONCE right here to avoid stacking!
			b.pressed.connect(button_answer.bind(b))
			
			var child_label: Label = null
			for child in b.get_children():
				if child is MarginContainer:
					for sub_child in child.get_children():
						if sub_child is Label:
							child_label = sub_child
							break
				elif child is Label:
					child_label = child
					
				if child_label:
					break 
			
			if child_label:
				labels.append(child_label)
			else:
				push_error("CRITICAL: Could not find a Label inside Button layout hierarchy: ", b.name)
	
	
	$Label.text = " " + str(GlobalVariables.tokens)
	load_quiz()


func load_quiz() -> void: 
	print("Loading quiz! Current index: ", index, " Total questions: ", shuffled_collection.size())
	if index >= 10:
		load_menu()
		return
		
	label_question.text = shuffled_collection[index].question_info
	var option = shuffled_collection[index].options
	var hint_text = shuffled_collection[index].hint
	# CLEAN: Only update UI text and font overrides here. Do NOT connect signals here!
	for i in buttons.size(): 
		if i < option.size():
			labels[i].text = option[i] 
			labels[i].add_theme_font_size_override("font_size", 60) 
	
	$Window/book/hint.text = hint_text
		
	match shuffled_collection[index].type: 
		question_type.question_Type.text: 
			image.texture = no_image
		question_type.question_Type.image: 
			$Control/Image.visible = true
			image.texture = shuffled_collection[index].question_image
			
func button_answer(button: Button) -> void: 
	for bt in buttons:
		bt.disabled = true

	var button_index = buttons.find(button)
	var correct_answer_text = shuffled_collection[index].correct
	
	
	if button_index != -1 and correct_answer_text == labels[button_index].text: 
		# Correct Answer
		sfx_right.play()
		button.modulate = color_right 
		GlobalVariables.tokens += 1
	
		$Skelly.icon = skelly_happy
		$Quizzard.icon = quizzard_angry
		
		$Label.text = " " + str(GlobalVariables.tokens)
	else: 
		# Wrong Answer - Highlight chosen button as wrong
		# FIX: Change the icon property instead of drawing
		sfx_wrong.play()
		shake_button(button)
		$Skelly.icon = skelly_tryagain
		$Quizzard.icon = quizzard_happy
		
		button.modulate = color_wrong
		
		# Find and highlight the actual correct button
		for i in buttons.size():
			if i < labels.size() and labels[i].text == correct_answer_text:
				buttons[i].modulate = color_right
				break
	$Control/Image.visible = false
	$"next button".visible = true 

	
func load_next_question() -> void: 
	$"next button".visible = false


	# Reset button states and colors for the next question
	for bt in buttons:
		bt.modulate = Color.WHITE
		bt.disabled = false 
	
	# RESET SKELLY: Clear the icon (or set it to a default idle texture if you have one)
	$Skelly.icon = skelly_help 
	$Quizzard.icon = quizzard_happy 
	
	index += 1 
	
	load_quiz()
func select_panel(panel: Panel) -> void: 
	for p in $Control/Panel_holder.get_children():
		if p == panel: 
			p.show() 
		else: 
			p.hide()
			
func load_menu() -> void: 
	get_tree().change_scene_to_packed(BLIND_BOX_SCENE)

func shake_button(button: Button) -> void:
	# Store the exact starting position so it resets perfectly afterward
	var original_pos = button.position
	var shake_tween = create_tween()
	
	# Configure the tween to run multiple movements sequentially
	# Moves left, right, left, right, and then returns to the center
	shake_tween.tween_property(button, "position:x", original_pos.x - 15, 0.05)
	shake_tween.tween_property(button, "position:x", original_pos.x + 15, 0.05)
	shake_tween.tween_property(button, "position:x", original_pos.x - 10, 0.05)
	shake_tween.tween_property(button, "position:x", original_pos.x + 10, 0.05)
	shake_tween.tween_property(button, "position:x", original_pos.x, 0.05)

func _on_change_scene_requested(target) -> void:
	if target is String and target == "QUIT":
		get_tree().quit()
	elif target is PackedScene:
		print("Switching to preloaded scene...")
		get_tree().change_scene_to_packed(target)


func _on_skelly_pressed() -> void:
	$Window.visible = true 

func _on_book_pressed() -> void:
	$Window.visible = false 


func _on_next_button_pressed() -> void:
	load_next_question()
