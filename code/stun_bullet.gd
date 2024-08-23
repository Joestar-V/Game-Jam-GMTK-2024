extends Node2D
var death = false
var targ
var trueroom
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(trueroom !=  get_tree().current_scene):
		global_position = Vector2(-100, -100)
		queue_free()
	var motion_vector=Vector2(1.5,0).rotated(rotation)
	$RigidBody2D.move_and_collide(motion_vector)
	if(death):
		if(!$AudioStreamPlayer.playing && !$AudioStreamPlayer2.playing):
			queue_free()
func initialize(angles, target,room):
	rotation = angles
	targ = target
	trueroom = room

func _on_area_2d_body_entered(body):

	if body.get_name() == "Player":
		body.stunned = true
		$"AudioStreamPlayer".play()
		global_position = Vector2(-100, -100)
		death = true


func _on_area_2d_area_entered(area):
	#if area.get_name() == "Heart":
	#	area.get_parent().health -= 1
	#	queue_free()
	pass


func _on_timer_timeout():
	queue_free()
