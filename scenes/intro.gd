extends Node2D

var type_speed: float = 15
var type_time: float

func _ready():
	display("You don't know who I am.")
	await get_tree().create_timer(5.0).timeout
	display("Neither do I know who you are.")

func display(text):
	$CanvasLayer/Label.text = text
	$CanvasLayer/Label.visible_characters = 0
	type_time = 0
	while $CanvasLayer/Label.visible_characters < $CanvasLayer/Label.get_total_character_count():
		type_time += get_process_delta_time()
		$CanvasLayer/Label.visible_characters = type_speed * type_time as int
		await get_tree().process_frame
