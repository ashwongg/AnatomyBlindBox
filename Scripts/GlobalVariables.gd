extends Node

var toggle = false 

var tokens = 10

var has_heart = toggle
var has_liver = toggle 
var has_brain = toggle 
var has_stomach = toggle 
var has_lungs = toggle 
var has_kidneys = toggle
var has_smallintestines = toggle  
var has_largeintestines = toggle 

var has_rare_heart = toggle
var has_rare_liver = toggle 
var has_rare_brain = toggle 
var has_rare_stomach = toggle 
var has_rare_lungs = toggle 
var has_rare_kidneys = toggle
var has_rare_smallintestines = toggle  
var has_rare_largeintestines = toggle 

func testing_true():
	has_heart = true
	has_liver = true 
	has_brain = true 
	has_stomach = true 
	has_lungs = true 
	has_kidneys = true
	has_smallintestines = true
	has_largeintestines = true 

	has_rare_heart = true
	has_rare_liver = true 
	has_rare_brain = true 
	has_rare_stomach = true 
	has_rare_lungs = true 
	has_rare_kidneys = true
	has_rare_smallintestines = true  
	has_rare_largeintestines = true 
	print("set all to true")

func testing_false():
	has_heart = false
	has_liver = false 
	has_brain = false 
	has_stomach = false 
	has_lungs = false 
	has_kidneys = false
	has_smallintestines = false  
	has_largeintestines = false 

	has_rare_heart = false
	has_rare_liver = false 
	has_rare_brain = false 
	has_rare_stomach = false 
	has_rare_lungs = false 
	has_rare_kidneys = false
	has_rare_smallintestines = false  
	has_rare_largeintestines = false 
	print("set all to false")
	
	
var all_common_organs_collected = false 

var played_intro_cutscene = false 
var played_ending_cutscene = false 
