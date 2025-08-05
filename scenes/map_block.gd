extends StaticBody2D

func _process(delta):
	if Input.is_action_just_released("r"):
		set_glasses_colour("r")
	if Input.is_action_just_released("g"):
		set_glasses_colour("g")
	if Input.is_action_just_released("b"):
		set_glasses_colour("b")

func set_glasses_colour(key):
	if Global.current_colour == key:
		key = "w"
	if key == "r":
		$Sprite2D.material.set_shader_parameter("colour", Vector3(1, 0, 0))
		$Sprite2D.material.set_shader_parameter("tint_factor", 0.5)
	if key == "g":
		$Sprite2D.material.set_shader_parameter("colour", Vector3(0, 1, 0))
		$Sprite2D.material.set_shader_parameter("tint_factor", 0.5)
	if key == "b":
		$Sprite2D.material.set_shader_parameter("colour", Vector3(0, 0, 1))
		$Sprite2D.material.set_shader_parameter("tint_factor", 0.5)
	if key == "w":
		$Sprite2D.material.set_shader_parameter("tint_factor", 0)
	Global.current_colour = key
