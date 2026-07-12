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
@onready var no_image: Texture = load("res://Assets/Questions_images/no_image.png")

# RE-ADDED: Reference your Back button node safely
@onready var back_button: Button = get_node_or_null("Back")

var shuffled_collection: Array = []

func _ready() -> void: 
	if quiz_c == null:
		push_error("CRITICAL: You forgot to assign a Question_collection resource to quiz_c in the Inspector!")
		return
		
	shuffled_collection = quiz_c.collection.duplicate()
	shuffled_collection.shuffle()
	
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
	
	# RE-ADDED & FIXED: Safely connect the back button right here
	if back_button:
		back_button.pressed.connect(_on_change_scene_requested.bind("res://Scenes/blind_box.tscn"))
	else:
		push_error("WARNING: Could not find a node named 'Back' in your scene root!")

	$Label.text = " : " + str(GlobalVariables.tokens)
	load_quiz()


func load_quiz() -> void: 
	print("Loading quiz! Current index: ", index, " Total questions: ", shuffled_collection.size())
	if index >= shuffled_collection.size():
		load_menu()
		return
		
	label_question.text = shuffled_collection[index].question_info
	var option = shuffled_collection[index].options
	
	# CLEAN: Only update UI text and font overrides here. Do NOT connect signals here!
	for i in buttons.size(): 
		if i < option.size():
			labels[i].text = option[i] 
			labels[i].add_theme_font_size_override("font_size", 60) 
		
	match shuffled_collection[index].type: 
		question_type.question_Type.text: 
			image.texture = no_image
		question_type.question_Type.image: 
			image.texture = shuffled_collection[index].question_image
			
func button_answer(button: Button) -> void: 
	for bt in buttons:
		bt.disabled = true

	var button_index = buttons.find(button)
	
	if button_index != -1 and shuffled_collection[index].correct == labels[button_index].text: 
		button.modulate = color_right 
		GlobalVariables.tokens += 1
		$Label.text = " : " + str(GlobalVariables.tokens)
	else: 
		button.modulate = color_wrong
	
	load_next_question()
	
func load_next_question() -> void: 
	await get_tree().create_timer(0.4).timeout
	
	# CLEAN: No disconnecting required anymore because we connected strictly once in _ready()
	for bt in buttons:
		bt.modulate = Color.WHITE
		bt.disabled = false 
	
	index += 1 
	load_quiz()


func select_panel(panel: Panel) -> void: 
	for p in $Control/Panel_holder.get_children():
		if p == panel: 
			p.show() 
		else: 
			p.hide()
		
func load_menu() -> void: 
	get_tree().change_scene_to_file("res://Scenes/blind_box.tscn")

# RE-ADDED: Missing scene controller utility
func _on_change_scene_requested(target: String) -> void:
	if target == "QUIT":
		get_tree().quit()
	else:
		print("Switching to scene: ", target)
		get_tree().change_scene_to_file(target)
