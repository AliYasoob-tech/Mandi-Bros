extends CanvasLayer

func _on_resume_button_pressed():
	# Unpause the game.
	get_tree().paused = false
	# Remove the pause menu from the scene.
	queue_free()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scenes/UI/main_menu.tscn")
