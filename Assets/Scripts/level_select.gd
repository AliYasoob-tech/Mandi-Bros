extends Control

const LevelButton = preload("res://Assets/Scenes/UI/level_button.tscn")

@onready var grid_container = $MarginContainer/VBoxContainer/GridContainer


#
# Levels database
var levels = [
	{
		"path": "res://Assets/Scenes/Areas/level_1.tscn",
		"name": "Level 1"
	},
	{
		"path": "res://Assets/Scenes/Areas/level_2.tscn", 
		"name": "Level 2"
	}
]



func _ready():
	populate_levels()
	$MarginContainer/VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)


func populate_levels():
	for level_data in levels:
		var level_button = LevelButton.instantiate()
		
		level_button.level_name = level_data.name
		level_button.level_path = level_data.path
		
		level_button.level_selected.connect(_on_level_selected)
		
		grid_container.add_child(level_button)


func _on_level_selected(level_path: String):
	get_tree().change_scene_to_file(level_path)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Assets/Scenes/UI/main_menu.tscn")
