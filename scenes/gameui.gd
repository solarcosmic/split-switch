extends CanvasLayer

func _ready():
	$Glasses/Exiting.modulate.a = 0
	$Glasses.modulate.a = 0
	# add code to fade in / out

var total = 0
func _process(delta):
	if Input.is_action_pressed("red"): # red button
		$Glasses.self_modulate = Color.from_rgba8(255, 0, 0, 102)
	if Input.is_action_pressed("esc"):
		total += delta
		print(total)
		$Exiting.modulate.a = 1
	if Input.is_action_just_released("esc"):
		total = 0
		$Exiting.modulate.a = 0
	if total > 1.5:
		total = 0
		$Exiting.modulate.a = 0
		get_tree().quit()
		print("Held escape for 1.5 seconds")
