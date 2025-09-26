extends Node2D

@export var player_controller : CharacterBody2D # It's better to type hint the actual node
@export var animated_sprite : AnimatedSprite2D # The new reference

func _process(_delta):
	if player_controller.velocity.x > 0:
		animated_sprite.flip_h = false
	elif player_controller.velocity.x < 0:
		animated_sprite.flip_h = true

	if not player_controller.is_on_floor():
		# Player is in the air
		if player_controller.velocity.y < 0:
			play_animation("jump")
		else:
			play_animation("fall")
	else:
		# Player is on the ground
		if player_controller.velocity.x != 0:
			play_animation("run")
		else:
			play_animation("idle")


func play_animation(anim_name: String):
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)
