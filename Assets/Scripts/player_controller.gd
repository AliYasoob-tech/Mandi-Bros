extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
@export var double_jump_power = 8.0

var can_double_jump = false 
var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var start_position: Vector2
var is_dead: bool = false

func _input(event):
	# Handle jump
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_power * jump_multiplier
			can_double_jump = true # Reset double jump ability when on the floor
		elif can_double_jump:
			velocity.y = double_jump_power * jump_multiplier
			can_double_jump = false # Consume the double jump

	# Handle jump down
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)
		
func _ready():
	start_position = global_position

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true

	# Get the input direction and handle the movement/deceleration
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()

func die():
	if is_dead:
		return
		
	is_dead = true

	$DeathSound.play()
	
	# Stop player from moving
	set_physics_process(false)
	
	await $DeathSound.finished
	# respawn 
	global_position = start_position
	velocity = Vector2.ZERO
	is_dead = false
	set_physics_process(true)
