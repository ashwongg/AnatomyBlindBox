extends Button

@onready var idle_box: AnimatedSprite2D = $"../spr_Idle_Box" 

func _ready() -> void:
	# Plays the animation immediately when the button enters the scene
	idle_box.play("idle_box")
	
