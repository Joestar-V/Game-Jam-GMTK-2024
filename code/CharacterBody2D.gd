extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var col2D = $CollisionShape2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var stretched = false
var stretched_y = false
var stretched_x = false
var cooldown = false
var spin = false
var buffer = false
func _physics_process(delta):
	if Input.is_action_pressed("horizontal")  && stretched_y == false && cooldown == false:
		stretched = true
		stretched_x = true
		col2D.scale.x = 2
		if anim.animation != ("hboil") && anim.animation != ("horizontal"):
			anim.play("horizontal")
		return
	elif Input.is_action_pressed("vertical")  && stretched_x == false && cooldown == false:
		stretched = true
		stretched_y = true
		col2D.scale.y = 2
		if anim.animation != ("vboil") && anim.animation != ("horizontal"):
			anim.play("vertical")
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
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if(Input.is_action_just_pressed("ui_accept") and is_on_floor() and Input.is_action_pressed("ui_left") and buffer):
		velocity.x = -velocity.x
		velocity.y = JUMP_VELOCITY
		spin = true
	elif(Input.is_action_just_pressed("ui_accept") and is_on_floor() and buffer and Input.is_action_pressed("ui_right")):
		velocity.x = - velocity.x
		velocity.y = JUMP_VELOCITY
		spin = true
	elif Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		spin = false
		rotation = 0
	
	if spin :
		rotation += .5
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if(velocity.x > 0.0 and Input.is_action_pressed("ui_left")):
		$Timer2.start()
		buffer = true
	if(velocity.x < 0.0 and Input.is_action_pressed("ui_right")):
		$Timer2.start()
		buffer = true
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	anim.play("idle")
	move_and_slide()

#func _input(event : InputEvent): 
	#if(event.is_action_pressed("ui_down") && is_on_floor):
	#	position.y += 1 


func _on_timer_timeout():
	cooldown = false


func _on_timer_2_timeout():
	buffer = false


func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "horizontal":
		anim.play("hboil")
	if anim.animation == "vertical":
		anim.play("vboil")
