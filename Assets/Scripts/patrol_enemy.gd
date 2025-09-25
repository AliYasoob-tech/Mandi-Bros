extends CharacterBody2D

@export var speed: float = 30.0
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction: int = 1

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = speed * direction
	move_and_slide()
	
	# Patrolling Logic.
	if is_on_wall():
		direction *= -1
		animated_sprite.flip_h = not animated_sprite.flip_h


func _on_damage_area_body_entered(body):
	if body.is_in_group("player"):
		# Call the player's die function.
		body.die()
