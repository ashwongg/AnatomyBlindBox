extends Control

var next_scene = preload("res://Scenes/quiz.tscn")
var main_menu = preload("res://Scenes/main.tscn")

func _on_video_stream_player_finished():
	if GlobalVariables.played_intro_cutscene == false: 
		GlobalVariables.played_intro_cutscene = true 
		get_tree().change_scene_to_packed(next_scene)
	else: 
		get_tree().change_scene_to_packed(main_menu)
