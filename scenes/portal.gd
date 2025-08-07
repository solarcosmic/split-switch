extends Node2D

@export var player: CharacterBody2D
var is_in_portal = false

func wait(amount):
	await get_tree().create_timer(amount).timeout

func _on_portal_body_entered(body: Node2D) -> void:
	if is_in_portal: return
	if body.name == "Player" and Global.level == 1:
		is_in_portal = true
		player.physics_enabled = false
		create_tween().tween_property(player, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
		await wait(1.0)
		Global.level = 2
		player.position = Vector2(111, -7760)
		create_tween().tween_property(player, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)
		player.physics_enabled = true
