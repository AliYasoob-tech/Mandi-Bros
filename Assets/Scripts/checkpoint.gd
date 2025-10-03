# Checkpoint.gd
extends Area2D

signal checkpoint_activated

var is_active = false

func _on_body_entered(body):
	if body.is_in_group("player") and not is_active:
		print("Checkpoint activated")
		
		GameManager.current_checkpoint_position = self.global_position
		print("GameManager position updated to: ", GameManager.current_checkpoint_position)
		
		is_active = true
		
		emit_signal("checkpoint_activated")
