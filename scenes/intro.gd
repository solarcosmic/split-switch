extends Node2D

@export var letter_object: Label
@export var grid_container: GridContainer
@export var main_label: Label
var type_speed: float = 15
var type_time: float
var is_in_grid = false

func _ready():
	$CanvasLayer/Label2.modulate.a = 0
	$CanvasLayer/GridContainer.modulate.a = 0
	main_label.text = "An SC Project"
	await get_tree().create_timer(2.0).timeout
	create_tween().tween_property(main_label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(2.0).timeout
	main_label.text = ""
	main_label.modulate.a = 1
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
	create_tween().tween_property(main_label, "position", Vector2($CanvasLayer/Label.position.x, $CanvasLayer/Label.position.y - 65), 1).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(0.5).timeout
	prepare_grid()
	create_tween().tween_property($CanvasLayer/Label2, "modulate:a", 0.5, 1).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($CanvasLayer/GridContainer, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)

func display(text):
	main_label.text = text
	main_label.visible_characters = 0
	type_time = 0
	while main_label.visible_characters < main_label.get_total_character_count():
		type_time += get_process_delta_time()
		main_label.visible_characters = type_speed * type_time as int
		await get_tree().process_frame

func add_letter_to_grid(i, name):
	var item = letter_object.duplicate()
	item.name = name
	item.text = i
	grid_container.add_child(item)
	return item

func prepare_grid():
	var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for i in alphabet:
		add_letter_to_grid(i, i)
	add_letter_to_grid("←", "backspace")
	is_in_grid = true
	grid_container.get_child(0).label_settings.font_color = Color(1, 0, 0)
	for label in grid_container.get_children():
		print(label.name)
