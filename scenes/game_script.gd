extends Node2D
var is_cutscene_finished = false
func wait(amount):
	await get_tree().create_timer(amount).timeout

func _ready():
	$"../Scenery/Sprite2D".modulate.a = 0
	$"../Scenery/Sprite2D2".modulate.a = 0
	$Camera2D.make_current()
	await wait(2.0)
	create_tween().tween_property($"../Player", "position", Vector2($"../Player".position.x, 564), 0.05).set_trans(Tween.TRANS_LINEAR)
	await wait(0.075)
	$Camera2D.apply_shake()
	$GroundHit.play()
	await wait(1.0)
	# for some reason the code below seems to .. do it instantly?
	create_tween().tween_property($"../Scenery/Sprite2D", "modulate:a", 0.5, 2).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($"../Scenery/Sprite2D2", "modulate:a", 0.5, 2).set_trans(Tween.TRANS_SINE)
	$"../Player/Camera2D".make_current()
	$"../Player/Camera2D".position_smoothing_enabled = true
	$Initial.play()
	$"../Player".physics_enabled = true
