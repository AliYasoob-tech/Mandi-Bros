extends Node2D

const PauseMenu = preload("res://Assets/Scenes/UI/pause_menu.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("toggle_pause"):
		get_tree().paused = not get_tree().paused
		
		if get_tree().paused:
			var pause_menu = PauseMenu.instantiate()
			add_child(pause_menu)
		else:
			if get_node_or_null("PauseMenu"):
				get_node("PauseMenu").queue_free()
