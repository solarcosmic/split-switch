extends Node2D

var is_in_portal = false

func wait(amount):
	await get_tree().create_timer(amount).timeout

func _on_portal_body_entered(body: Node2D) -> void:
	if is_in_portal: return
	if body.name == "Player":
		is_in_portal = true
		$"../../GameScript/CollectGlasses".play()
		$"../../Player".physics_enabled = false
		create_tween().tween_property($"../../Player", "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
		await wait(1.0)
		$"../../Player".physics_enabled = true
