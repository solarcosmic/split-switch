extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300
@export var physics_enabled = false
var friction = 600

func _physics_process(delta):
	if !physics_enabled: return
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	if Input.is_action_pressed("r"):
		velocity.y = -800
	
	var horizontal_direction = Input.get_axis("left", "right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
