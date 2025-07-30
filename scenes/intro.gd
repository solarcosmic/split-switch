extends Node2D

var type_speed: float = 15
var type_time: float

func _ready():
	$CanvasLayer/Label2.modulate.a = 0
	$CanvasLayer/GridContainer.modulate.a = 0
	$CanvasLayer/Label.text = "An SC Project"
	await get_tree().create_timer(2.0).timeout
	$CanvasLayer/Label.text = ""
	await get_tree().create_timer(2.0).timeout
	$CanvasLayer/AudioStreamPlayer.play()
	display("You don't know who I am.")
	await get_tree().create_timer(5.0).timeout
	display("... neither do I know who you are.")
	await get_tree().create_timer(6.0).timeout
	display("Let us create someone new.")
	await get_tree().create_timer(5.0).timeout
	display("Who do you want to be?")
	await get_tree().create_timer(2.0).timeout
	create_tween().tween_property($CanvasLayer/Label, "position", Vector2($CanvasLayer/Label.position.x, $CanvasLayer/Label.position.y - 65), 1).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(0.5).timeout
	create_tween().tween_property($CanvasLayer/Label2, "modulate:a", 0.5, 1).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($CanvasLayer/GridContainer, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)

func display(text):
	$CanvasLayer/Label.text = text
	$CanvasLayer/Label.visible_characters = 0
	type_time = 0
	while $CanvasLayer/Label.visible_characters < $CanvasLayer/Label.get_total_character_count():
		type_time += get_process_delta_time()
		$CanvasLayer/Label.visible_characters = type_speed * type_time as int
		await get_tree().process_frame
