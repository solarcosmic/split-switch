extends Node2D
class_name Intro

@export var letter_object: Label
@export var grid_container: GridContainer
@export var main_label: Label
@export var letter_scene: PackedScene
@export var wait_multiplier: float
@export var name_label: Label
var type_speed: float = 15
var type_time: float
var is_in_grid = false
var finished_name_check = false
var finished_term = false

func wait(amount):
	await get_tree().create_timer(amount * wait_multiplier).timeout

func _ready():
	$CanvasLayer/Label2.modulate.a = 0
	grid_container.modulate.a = 0
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
	display("I know who you are.")
	await wait(4.0)
	display("Let us create another being.")
	await wait(4.0)
	display("What do you want to name it?")
	await wait(2.0)
	create_tween().tween_property(main_label, "position", Vector2($CanvasLayer/Label.position.x, $CanvasLayer/Label.position.y - 90), 1).set_trans(Tween.TRANS_SINE)
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
	for label in grid_container.get_children():
		print(label.name)

func lsprocess():
	for label in grid_container.get_children():
		label.modulate = Color(1,1,1)
	print(grid_container.get_child(cur_index))
	grid_container.get_child(cur_index).modulate = Color(1,0,0)

func set_cur_index(amount):
	if amount > 26 or amount < 1:
		if amount < 0:
			cur_index = 26
		else:
			cur_index = 0
	else:
		cur_index = amount
	lsprocess()

func _process(delta):
	if is_in_grid:
		if Input.is_action_just_released("right_arrow"):
			set_cur_index(cur_index + 1)
		if Input.is_action_just_released("left_arrow"):
			set_cur_index(cur_index - 1)
		if Input.is_action_just_released("enter"):
			var character = grid_container.get_child(cur_index).text
			if character == "←":
				name_label.text = name_label.text.left(name_label.text.length() - 1)
			else:
				if name_label.text.length() < 7:
					name_label.text += character
		if Input.is_action_just_released("down_arrow"):
			if cur_index + 9 < 27:
				set_cur_index(cur_index + 9)
		if Input.is_action_just_released("up_arrow"):
			if cur_index - 9 >= 0:
				set_cur_index(cur_index - 9)
	if Input.is_action_just_released("x"):
		if not finished_name_check and is_in_grid:
			finished_name_check = true
			is_in_grid = false
			create_tween().tween_property($CanvasLayer/Label2, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			create_tween().tween_property($CanvasLayer/GridContainer, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			create_tween().tween_property($CanvasLayer/Label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			await wait(2.0)
			main_label.text = ""
			main_label.modulate.a = 1
			display("Are you satisfied with this name?")
			await wait(3.0)
			finished_term = true
			$CanvasLayer/Label2.text = "Press X to continue, N to go back."
			create_tween().tween_property($CanvasLayer/Label2, "modulate:a", 0.5, 1).set_trans(Tween.TRANS_SINE)
		elif finished_term and finished_name_check:
			create_tween().tween_property($CanvasLayer/Label2, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			create_tween().tween_property(main_label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			await wait(1.5)
			$CanvasLayer/AudioStreamPlayer.stop()
			name_label.text = ""
			main_label.modulate.a = 0
			await wait(1.5)
			main_label.position = Vector2($CanvasLayer/Label.position.x, $CanvasLayer/Label.position.y + 90)
			main_label.text = ""
			main_label.modulate.a = 1
			display("No one gets to choose.")
			await wait(5)
			main_label.text = ""
			main_label.modulate.a = 0
			await wait(2)
			get_tree().change_scene_to_file("res://scenes/world.tscn")
	if Input.is_action_just_released("n"):
		if finished_term and finished_name_check:
			create_tween().tween_property($CanvasLayer/Label2, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			create_tween().tween_property(main_label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			create_tween().tween_property(name_label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
			await wait(2)
			main_label.text = ""
			main_label.modulate.a = 1
			main_label.position = Vector2($CanvasLayer/Label.position.x, $CanvasLayer/Label.position.y + 90)
			name_label.text = ""
			name_label.modulate.a = 1
			display("What do you want to name it?")
			await wait(2.0)
			is_in_grid = true
			finished_term = false
			finished_name_check = false
			create_tween().tween_property(main_label, "position", Vector2($CanvasLayer/Label.position.x, $CanvasLayer/Label.position.y - 90), 1).set_trans(Tween.TRANS_SINE)
			await wait(0.5)
			create_tween().tween_property($CanvasLayer/Label2, "modulate:a", 0.5, 1).set_trans(Tween.TRANS_SINE)
			create_tween().tween_property($CanvasLayer/GridContainer, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)
