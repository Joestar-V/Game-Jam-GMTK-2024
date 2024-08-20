extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D
@onready var col = $CollisionShape2D


const SPEED = 360.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var stretched = false
var stretched_y = false
var stretched_x = false
var cooldown = false
var spin = false
var buffer = false
var stunned = false
var frozen = false

@export var coyote_time_max : = 13
@export var jump_buffer_max : = 6

var coyote_time: float
var jump_buffer: float
@export var max_gravity : = 1000

@onready var jump_velocity : float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity : float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity : float = (2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)
@export var fall_velocity_max : = -17.7

@export var jump_height : = 100.8
@export var jump_time_to_peak : = 0.33
@export var jump_time_to_descent : = 0.37

func get_gravity(velocity: Vector2):
	if velocity.y < 0:
		return jump_gravity
	return fall_gravity

func _physics_process(delta):
	if(stunned) :
		stunned = false
		frozen = true
		$Timer3.start()
	if(frozen):
		sprite.self_modulate = Color("blue")
		return
	else :
		sprite.self_modulate = Color("white")
	if Input.is_action_just_pressed("horizontal")  && stretched_y == false && cooldown == false:
		sprite.play("horizontal")
		
	if Input.is_action_just_pressed("vertical")  && stretched_x == false && cooldown == false:
		sprite.play("vertical")
		
	if Input.is_action_pressed("horizontal")  && stretched_y == false && cooldown == false:
		stretched = true
		stretched_x = true
		sprite.rotation = 0
		col.scale.x = 2
		return
	elif Input.is_action_pressed("vertical")  && stretched_x == false && cooldown == false:
		stretched = true
		stretched_y = true
		sprite.rotation = 0
		col.scale.y = 2
		return
	else :
		if sprite.animation != "idle":
			sprite.play("idle")
		if(stretched == true):
			cooldown = true
			 
			$Timer.start()
		stretched = false
		stretched_y = false
		stretched_x = false
		
		col.scale.x = .5
		col.scale.y = .5
	
	# Add the gravity.
	if not is_on_floor():
		if(velocity.y <= max_gravity) :
			velocity.y += get_gravity(velocity) * delta
		coyote_time -= 1
		jump_buffer -= 1
	if is_on_floor():
		coyote_time = coyote_time_max
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		jump_buffer = jump_buffer_max
	# Handle jump.
	if(Input.is_action_just_pressed("ui_accept") and Input.is_action_pressed("ui_left") and buffer and ((is_on_floor() or coyote_time > 0) or (is_on_floor() and jump_buffer > 0))):
		velocity.x = -velocity.x
		velocity.y = JUMP_VELOCITY - 180.0
		spin = true
	elif(Input.is_action_just_pressed("ui_accept") and buffer and Input.is_action_pressed("ui_right") and ((is_on_floor() or coyote_time > 0) or (is_on_floor() and jump_buffer > 0))):
		velocity.x = - velocity.x
		velocity.y = JUMP_VELOCITY - 180.0
		spin = true
	elif Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote_time > 0) or (is_on_floor() and jump_buffer > 0):
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		spin = false
		sprite.rotation = 0
	
	if spin :
		sprite.rotation += .5
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if(velocity.x > 0.0 and !Input.is_action_pressed("ui_right")):
		$Timer2.start()
		buffer = true
	if(velocity.x < 0.0 and !Input.is_action_pressed("ui_left")):
		$Timer2.start()
		buffer = true
		
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


func _on_timer_2_timeout():
	buffer = false


func _on_timer_3_timeout():
	frozen = false


func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "vertical" :
		sprite.play("vboil")
	if sprite.animation == "horizontal" :
		sprite.play("hboil")
