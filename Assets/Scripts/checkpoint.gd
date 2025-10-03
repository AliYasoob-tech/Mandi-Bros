# Checkpoint.gd
extends Area2D

# This signal is useful for playing sounds or animations.
signal checkpoint_activated

var is_active = false

func _on_body_entered(body):
	print("Checkpoint touched by: ", body.name) # <-- ADD THIS LINE
	
	# Check if the body that entered is the player and if this checkpoint isn't already active.
	if body.is_in_group("player") and not is_active:
		print("Player detected! Activating checkpoint.") # <-- ADD THIS LINE
		print("Checkpoint activated!")
		
		# Update the global spawn position in our GameManager.
		GameManager.current_checkpoint_position = self.global_position
		print("GameManager position updated to: ", GameManager.current_checkpoint_position)
		
		is_active = true
		
		# Emit the signal for visual/audio feedback.
		emit_signal("checkpoint_activated")
