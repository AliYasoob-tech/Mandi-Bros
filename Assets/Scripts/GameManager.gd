extends Node

signal score_updated(new_score)

var current_score: int = 0

func add_score(amount: int):
	current_score += amount
	score_updated.emit(current_score)

func reset_score():
	current_score = 0

var current_checkpoint_position: Vector2 = Vector2.ZERO
