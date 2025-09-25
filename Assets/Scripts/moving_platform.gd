extends Path2D
class_name MovingPlatform

@export var path_time = 1.0
@export var looping = false # If true, jumps back to the start. If false, it "ping-pongs".
@export var _ease : Tween.EaseType
@export var transition : Tween.TransitionType
@export var path_follow_2D : PathFollow2D


func _ready():
	if not is_instance_valid(path_follow_2D):
		print_rich("[color=red]ERROR: PathFollow2D is not assigned on MovingPlatform.[/color]")
		return

	move_tween()


func move_tween():
	var tween = create_tween()

	tween.set_loops()

	if looping:
		# simple loop: Move to the end, then instantly snap back to the start.
		tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time).set_ease(_ease).set_trans(transition)
		tween.tween_property(path_follow_2D, "progress_ratio", 0.0, 0.0) # Snap back in 0 seconds.
	else:
		# "Ping-Pong" loop: Move to the end, then move back to the start.
		tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time).set_ease(_ease).set_trans(transition)
		tween.tween_property(path_follow_2D, "progress_ratio", 0.0, path_time).set_ease(_ease).set_trans(transition)
