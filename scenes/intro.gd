extends Node2D
class_name Intro

@export var letter_object: Label
@export var grid_container: GridContainer
@export var main_label: Label
@export var letter_scene: PackedScene
@export var wait_multiplier: float
var type_speed: float = 15
var type_time: float
var is_in_grid = false

func wait(amount):
	await get_tree().create_timer(amount * wait_multiplier).timeout

func _ready():
	$CanvasLayer/Label2.modulate.a = 0
	main_label.text = "An SC Project"
	await wait(2.0)
	create_tween().tween_property(main_label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
	await wait(2.0)
	main_label.text = ""
	main_label.modulate.a = 1
	await wait(2.0)
	$CanvasLayer/AudioStreamPlayer.play()
	display("You don't know who I am.")
	await wait(5.0)
	display("... neither do I know who you are.")
	await wait(6.0)
	display("Let us create someone new.")
	await wait(5.0)
	display("Who do you want to be?")
	await wait(2.0)
	create_tween().tween_property(main_label, "position", Vector2($CanvasLayer/Label.position.x, $CanvasLayer/Label.position.y - 65), 1).set_trans(Tween.TRANS_SINE)
	prepare_grid()
	await wait(0.5)
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
	var node_ins: Label = letter_scene.instantiate() as Label
	node_ins.name = name
	node_ins.text = i
	print(node_ins.label_settings.font_color)
	grid_container.add_child(node_ins)
	#var item = letter_object.duplicate()
	#item.name = name
	#item.text = i
	#grid_container.add_child(item)
	#print("i is: " + i)
	if i == "A":
		print("i is indeed A!")
		node_ins.modulate = Color(1,0,0)
	else:
		node_ins.modulate = Color(1,1,1)

var cur_index = 0
func prepare_grid():
	var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for i in alphabet:
		add_letter_to_grid(i, i)
	add_letter_to_grid("←", "backspace")
	is_in_grid = true
	#grid_container.get_child(0).label_settings.font_color = Color(1, 0, 0)
	if Input.is_action_just_released("right_arrow"): # doesn't work
		cur_index += 1
		print(grid_container.get_child(cur_index))
		grid_container.get_child(cur_index).modulate = Color(1,0,0)
	for label in grid_container.get_children():
		print(label.name)
