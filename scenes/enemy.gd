extends Area2D

var direction = Vector2.UP
var SPEED = 70

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta



func _on_body_entered(body: Node2D) -> void:
	if body is Torpedo:
		queue_free()
