# Quiz Tutorial: https://www.youtube.com/watch?v=JSCU8Wt3dEk 

extends Node2D 

@export var quiz_c: Question_collection
@export var color_right : Color
@export var color_wrong : Color 

var buttons : Array[Button]
var index : int 
var correct: int 

@onready var label_question: Label = $Control/Label_Question
@onready var question: Node2D = $Control/Question
@onready var image: TextureRect = $Control/Image
@onready var no_image: Texture = load("res://Assets/Questions_images/no_image.png")

# FIX 1: Just define the array here without loading the collection data yet
var shuffled_collection: Array = []

func _ready() -> void: 
	# FIX 2: Check if you forgot to drag the resource into the Inspector
	if quiz_c == null:
		push_error("CRITICAL: You forgot to assign a Question_collection resource to quiz_c in the Inspector!")
		return
		
	# FIX 3: Safe to duplicate and shuffle now that everything is loaded
	shuffled_collection = quiz_c.collection.duplicate()
	shuffled_collection.shuffle()
	
	for b in question.get_children():
		buttons.append(b)
	load_quiz()
	$Label.text = "Tokens: " + str(GlobalVariables.tokens)

func load_quiz() -> void: 
	print("Loading quiz! Current index: ", index, " Total questions: ", shuffled_collection.size())
	# Check the size of the array directly
	if index >= shuffled_collection.size():
		load_menu()
		return
		
	# Pull the question from your SHUFFLED list, not the original one!
	label_question.text = shuffled_collection[index].question_info
	
	var option = shuffled_collection[index].options
	for i in buttons.size(): 
		buttons[i].text = option[i]
		buttons[i].pressed.connect(button_answer.bind(buttons[i]))
		
	match shuffled_collection[index].type: 
		question_type.question_Type.text: 
			image.texture = no_image
		question_type.question_Type.image: 
			image.texture = shuffled_collection[index].question_image
			
# Checks if the answer is right or wrong    
func button_answer(button) -> void: 
	# 1. Instantly disable all buttons so player can't spam click during the 1-second pause
	for bt in buttons:
		bt.disabled = true

	if shuffled_collection[index].correct == button.text: 
		button.modulate = color_right 
		GlobalVariables.tokens += 1
		$Label.text = "Tokens: " + str(GlobalVariables.tokens)
	else: 
		button.modulate = color_wrong
	
	load_next_question()
	
func load_next_question() -> void: 
	# Wait 1 second to show the right/wrong color feedback
	await get_tree().create_timer(1).timeout
	
	# 2. Reset everything for the next question
	for bt in buttons:
		bt.modulate = Color.WHITE
		bt.disabled = false # Re-enable them
		# Cleanly unbind the old connections before we create new ones in load_quiz
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
