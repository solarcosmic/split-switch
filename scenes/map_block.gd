extends StaticBody2D

func _process(delta):
	if Input.is_action_pressed("r"):
		$Sprite2D.material.set_shader_parameter("colour", Vector3(1, 0, 0))
		$Sprite2D.material.set_shader_parameter("tint_factor", 0.5)
	if Input.is_action_pressed("g"):
		$Sprite2D.material.set_shader_parameter("colour", Vector3(0, 1, 0))
		$Sprite2D.material.set_shader_parameter("tint_factor", 0.5)
	if Input.is_action_pressed("b"):
		$Sprite2D.material.set_shader_parameter("colour", Vector3(0, 0, 1))
		$Sprite2D.material.set_shader_parameter("tint_factor", 0.5)
