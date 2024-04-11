extends CharacterBody2D


const SPEED = 300.0

func _ready() -> void:
	velocity = Vector2(1,0) * SPEED
	velocity = velocity.rotated(PI/2)

func _physics_process(delta: float) -> void:

	move_and_slide()
