extends CanvasLayer

var next_level_path: String

@onready var next_level_button = $CenterContainer/VBoxContainer/NextLevelButton

func _ready():
	if next_level_path.is_empty():
		next_level_button.disabled = true
		next_level_button.text = "Game Finished!"


func _on_next_level_button_pressed():
	get_tree().paused = false
	
	queue_free()
	
	get_tree().change_scene_to_file(next_level_path)


func _on_main_menu_button_pressed():
	# Unpause the game before changing scenes
	get_tree().paused = false
	
	queue_free()
	
	# change to the main menu.
	get_tree().change_scene_to_file("res://Assets/Scenes/UI/main_menu.tscn")
