extends Control

var main_menu = preload("res://Scenes/main.tscn")

func _on_video_stream_player_finished():
		get_tree().change_scene_to_packed(main_menu)
