extends Node2D

var has_stand = false

func wait(amount):
	await get_tree().create_timer(amount).timeout

func _on_glass_stand_body_entered(body: Node2D) -> void:
	if has_stand: return
	if body.name == "Player":
		has_stand = true
		$"../../GameScript/CollectGlasses".play()
		$"../../Player".physics_enabled = false
		create_tween().tween_property($Sprite2D, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
		await wait(1.0)
		$"../../Player".physics_enabled = true
