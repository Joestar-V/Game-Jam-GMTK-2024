extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var stretched = false
var stretched_y = false
var stretched_x = false
var cooldown = false
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_pressed("horizontal") && Input.is_action_pressed("shift") && stretched_y == false && cooldown == false:
		stretched = true
		stretched_x = true
		scale.x = 2
		return
	elif Input.is_action_pressed("vertical") && Input.is_action_pressed("shift") && stretched_x == false && cooldown == false:
		stretched = true
		stretched_y = true
		scale.y = 2
		return
	else :
		if(stretched == true):
			cooldown = true
			 
			$Timer.start()
		stretched = false
		stretched_y = false
		stretched_x = false
		scale.x = .3
		scale.y = .3
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#func _input(event : InputEvent): 
	#if(event.is_action_pressed("ui_down") && is_on_floor):
	#	position.y += 1 


func _on_timer_timeout():
	cooldown = false
