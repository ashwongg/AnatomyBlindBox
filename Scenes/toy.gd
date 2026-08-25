extends CharacterBody2D

@export var speed: int = 50
@export var item_type: String = "toy" 
var altTexture = preload("res://Assets/Minigame/orange.png")

func _ready() -> void:
	var rand = randi_range(0,6)
	if (rand <=3): 
		$Sprite2D.texture = altTexture

func _physics_process(delta: float) -> void: 
	velocity.x = speed
	move_and_slide()
