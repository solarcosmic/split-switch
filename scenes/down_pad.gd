extends Area2D
@export var velocity = 1000

func _on_body_entered(body: Node2D) -> void:
	if "velocity" in body:
		body.velocity.y = velocity
