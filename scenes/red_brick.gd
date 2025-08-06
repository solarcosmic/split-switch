extends Area2D

func wait(amount):
	await get_tree().create_timer(amount).timeout

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		create_tween().tween_property($"../../Player", "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
		$"../../Player".physics_enabled = false
		await wait(2.0)
		$"../../Player".position = Vector2(111, 560)
		create_tween().tween_property($"../../Player", "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)
		await wait(1.0)
		$"../../Player".physics_enabled = true
