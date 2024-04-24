extends CharacterBody2D


@export var speed : float = 200
@export var jump_velocity : float = -350.0
@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		#animated_sprite.play("Jumping_Start")
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 12)
	
	move_and_slide()
	movement_animations(direction)
	
	# Flip Character when go opposite direction
	if Input.is_action_just_pressed('left'):
		animated_sprite.flip_h = true
	if Input.is_action_just_pressed('right'):
		animated_sprite.flip_h = false

#Movement Animations	
func movement_animations(direction):
	if is_on_floor():
		if direction != 0:
			animated_sprite.play("Run")
		else:
			animated_sprite.play("Idle")
	else:
		if velocity.y < 1:
			animated_sprite.play("Jumping_Start")
		else:
			animated_sprite.play("Fall")


		
			
	
	
	
	
	
