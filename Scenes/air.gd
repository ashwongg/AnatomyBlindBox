extends CharacterBody2D

@export var speed: int = 50
@export var item_type: String = "air" 


func _physics_process(delta: float) -> void: 
	velocity.x = speed
	move_and_slide()
