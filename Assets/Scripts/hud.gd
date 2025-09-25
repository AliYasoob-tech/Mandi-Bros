extends CanvasLayer

@onready var score_label = $HBoxContainer/ScoreLabel

func _ready():
	GameManager.score_updated.connect(update_score_label)
	
	# Set the initial score.
	update_score_label(GameManager.current_score)

func update_score_label(new_score):
	score_label.text = "x " + str(new_score)
