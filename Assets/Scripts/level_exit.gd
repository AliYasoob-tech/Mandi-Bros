extends Area2D

const LevelCompleteMenu = preload("res://Assets/Scenes/UI/level_complete_menu.tscn")

@export var next_level_path: String

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Freeze the game.
		get_tree().paused = true
		
		var menu = LevelCompleteMenu.instantiate()
		
		menu.next_level_path = next_level_path
		
		get_tree().get_root().add_child(menu)
