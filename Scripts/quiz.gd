extends Node2D 

@export var quiz_c: Question_collection
@export var color_right : Color
@export var color_wrong : Color 

# CHANGED: Separate your clickable buttons from your text labels
var buttons : Array[Button] = []
var labels : Array[Label] = []

var index : int 
var correct: int 

@onready var label_question: Label = $Control/Label_Question
@onready var question: Node2D = $Control/Question
@onready var image: TextureRect = $Control/Image
@onready var no_image: Texture = load("res://Assets/Questions_images/no_image.png")

var shuffled_collection: Array = []

func _ready() -> void: 
	
	if quiz_c == null:
		push_error("CRITICAL: You forgot to assign a Question_collection resource to quiz_c in the Inspector!")
		return
		
	shuffled_collection = quiz_c.collection.duplicate()
	shuffled_collection.shuffle()
	
	# CHANGED: Grabs the button nodes AND their child Label nodes
	for b in question.get_children():
		if b is Button:
			buttons.append(b)
			# Assumes the Label is the first child node inside your Button
			var child_label = b.get_child(0) as Label
			if child_label:
				labels.append(child_label)
			else:
				push_error("Missing child Label inside button: ", b.name)
	
	load_quiz()
	$Label.text = " : " + str(GlobalVariables.tokens)

func load_quiz() -> void: 
	var custom_font = load("res://resources/fonts/CarbonBold W00 Regular.ttf")
	print("Loading quiz! Current index: ", index, " Total questions: ", shuffled_collection.size())
	if index >= shuffled_collection.size():
		load_menu()
		return
		
	label_question.text = shuffled_collection[index].question_info
	
	var option = shuffled_collection[index].options
	
	# CHANGED: Populate option text into labels array, but connect listeners to buttons array
	for i in buttons.size(): 
		labels[i].text = option[i] # Text goes into the inner Label
		labels[i].add_theme_font_size_override("font_size", 200) 
		labels[i].add_theme_font_override("font", custom_font) 
		buttons[i].pressed.connect(button_answer.bind(buttons[i])) # Click logic stays on the Button
		
	match shuffled_collection[index].type: 
		question_type.question_Type.text: 
			image.texture = no_image
		question_type.question_Type.image: 
			image.texture = shuffled_collection[index].question_image
			
func button_answer(button) -> void: 
	for bt in buttons:
		bt.disabled = true

	if shuffled_collection[index].correct == button.get_child(0).text: # CHANGED: Checks label text instead of button text
		button.modulate = color_right 
		GlobalVariables.tokens += 1
		$Label.text = "Tokens: " + str(GlobalVariables.tokens)
	else: 
		button.modulate = color_wrong
	
	load_next_question()
	
func load_next_question() -> void: 
	await get_tree().create_timer(1).timeout
	
	for bt in buttons:
		bt.modulate = Color.WHITE
		bt.disabled = false 
		if bt.pressed.is_connected(button_answer):
			bt.pressed.disconnect(button_answer)
	
	index += 1 
	load_quiz()

func select_panel(panel: Panel) -> void: 
	for p in $Control/Panel_holder.get_children():
		if p==panel: 
			p.show() 
		else: 
			p.hide()
		
func load_menu() -> void: 
	get_tree().change_scene_to_file("res://Scenes/blind_box.tscn")
