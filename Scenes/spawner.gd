extends Node2D

@export var food_scene : PackedScene 
@export var air_scene : PackedScene 
@export var toy_scene : PackedScene 

func _on_timer_timeout() -> void:
	# Put all scenes into an array and pick one at random
	var scenes = [food_scene, air_scene, toy_scene]
	var selected_scene : PackedScene = scenes.pick_random()
	
	# Instantiate and add to parent if the scene exists
	if selected_scene:
		var item = selected_scene.instantiate()
		item.position = position
		get_parent().add_child(item)
