@tool
extends Control

signal level_selected(level_path: String)

@export var level_name: String = "Level" : set = set_level_name
@export var level_path: String

func _ready():
	$Button.pressed.connect(_on_button_pressed)

func set_level_name(new_name: String):
	level_name = new_name
	if has_node("Button"):
		$Button.text = level_name

func _on_button_pressed():
	level_selected.emit(level_path)
