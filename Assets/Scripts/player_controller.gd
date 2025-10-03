extends CharacterBody2D
class_name PlayerController

# --- Movement ---
@export_category("Movement")
@export var max_speed = 300.0
@export var acceleration = 1500.0
@export var friction = 1200.0
@export var air_acceleration_multiplier = 0.6 # How much air control the player has (0-1)

# --- Jumping ---
@export_category("Jumping")
@export var jump_velocity = -350.0
@export var variable_jump_height = true
@export var jump_release_multiplier = 0.5 # How much the jump is shortened on release

# --- Gravity ---
@export_category("Gravity")
@export var gravity_scale = 1.0
@export var falling_gravity_multiplier = 2.0 # Applied when falling for a less floaty jump
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# --- Feel ---
@export_category("Feel")
@export var coyote_time_duration = 0.1 # Time to jump after leaving a ledge
@export var jump_buffer_time_duration = 0.1 # Time to buffer a jump before landing


var coyote_timer = 0.0
var jump_buffer_timer = 0.0

var start_position: Vector2
var is_dead: bool = false

func _ready():
	start_position = global_position
	GameManager.current_checkpoint_position = self.global_position

func _input(event):
	if event.is_action_pressed("jump"):
		jump_buffer_timer = jump_buffer_time_duration

	# variable jump height
	if event.is_action_released("jump") and variable_jump_height:
		if velocity.y < 0:
			velocity.y *= jump_release_multiplier

	# one-way platforms
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func _physics_process(delta):
	var current_gravity = gravity * gravity_scale
	if velocity.y > 0: # Apply stronger gravity when falling
		current_gravity *= falling_gravity_multiplier
	velocity.y += current_gravity * delta
	
	
	coyote_timer -= delta
	jump_buffer_timer -= delta
	
	if is_on_floor():
		coyote_timer = coyote_time_duration

	# --- Jumping ---
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = jump_velocity
		jump_buffer_timer = 0 
		coyote_timer = 0 

	# --- Horizontal Movement ---
	var direction = Input.get_axis("move_left", "move_right")
	
	var current_accel = acceleration
	if not is_on_floor():
		current_accel *= air_acceleration_multiplier

	if direction != 0:
		velocity.x = move_toward(velocity.x, max_speed * direction, current_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	move_and_slide()

func die():
	if is_dead:
		return
	is_dead = true
	$DeathSound.play()
	set_physics_process(false)
	await $DeathSound.finished
	print("Player died. Respawning at GameManager position: ", GameManager.current_checkpoint_position)
	global_position = GameManager.current_checkpoint_position
	velocity = Vector2.ZERO
	is_dead = false
	set_physics_process(true)
