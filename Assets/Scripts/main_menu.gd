extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/level_1.tscn")


func _on_select_level_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/UI/level_select.tscn")
	#pass


func _on_options_pressed() -> void:
	print("Options button pressed!")


func _on_exit_pressed() -> void:
	get_tree().quit()
